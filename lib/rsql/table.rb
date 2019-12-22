module Rsql
  class Table
    require 'rsql/column'
    require 'rsql/sequence'

    class UnknownColumnError < StandardError
    end

    include Enumerable

    attr_reader :columns

    alias :where :select

    def initialize(columns: {}, rows: [], sequence: Sequence.new)
      @columns = columns
      @rows = {}
      @sequence = sequence

      rows.each {|row| insert(row, skip_constraints: true) }
    end

    def each(&block)
      @rows.values.each(&block)
    end

    def add_column(name, type, **type_args)
      constraint = case type
                  when :string
                    Column::String.new type_args
                  when :integer
                    Column::Integer.new type_args
                  when Class
                    raise NotImplementedError
                  end
      @columns[name.to_sym] = constraint
    end

    def insert(row, skip_constraints: false)
      unless skip_constraints
        if (unknown_columns = row.keys - @columns.keys).any?
          raise UnknownColumnError, unknown_columns
        end
        @columns.each { |name, constraint| constraint.assert! row[name] }
      end
      @rows[@sequence.next!] = row
    end

    def select(*columns)
      columns << :* if columns.empty?

      if columns.include? :*
        Table.new(columns: @columns.dup, rows: @rows.values)
      else
        cols = columns.map(&:to_sym)
        Table.new(
          columns: @columns.slice(*cols),
          rows: @rows.values.map {|row| row.slice(*cols) }
        )
      end
    end
  end
end
