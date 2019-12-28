module Rsql
  class Table
    require 'rsql/column'
    require 'rsql/sequence'

    class UnknownColumnError < StandardError; end

    include Enumerable

    attr_reader :columns

    alias :filter :select

    def initialize(columns: {}, rows: [], sequence: Sequence.new)
      if columns.is_a? Array
        @columns = {}
        columns.each { |args| add_column(*args) }
      else
        @columns = columns
      end
      @rows = {}
      @sequence = sequence

      rows.each {|row| insert(row, skip_constraints: true) }
    end

    def each(&block)
      @rows.values.each(&block)
    end

    def add_column(name, type, **type_args)
      constraint = case type
                  when :string, :text
                    Column::String.new type_args
                  when :integer, :int
                    Column::Integer.new type_args
                  when Class
                    raise NotImplementedError
                  else raise "type \"#{type}\" does not exist"
                  end
      @columns[name.to_sym] = constraint
    end

    def insert(row, skip_constraints: false)
      unless skip_constraints
        if (unknown_columns = row.keys - @columns.keys).any?
          raise UnknownColumnError, unknown_columns
        end
        @columns.each { |name, constraint| constraint.assert! name, row[name] }
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

    def where(*args, &block)
      return filter(*args, &block) if block_given?
      op = args.shift
      args.flatten!
      res = case op
      when :<, :<=, :>=, :>
        filter { |row| fetch_value(args[0], row).send(op, fetch_value(args[1], row)) }
      else raise NotImplementedError
      end
      # TODO: should we dup here?
      Table.new(columns: @columns, rows: res)
    end

    private

    def fetch_value(key_or_value, row)
      return key_or_value unless key_or_value.kind_of?(Symbol)
      row[key_or_value]
    end
  end
end
