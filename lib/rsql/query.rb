require 'forwardable'

module Rsql
  class Query
    extend Forwardable

    def self.call(database, query_str)
      p = Parser.new
      sexp = p.parse(query_str)
      new(database, *sexp).call
    end

    def_delegators :@database, :from, :create_table

    def initialize(database, *args)
      @database = database
      @args = args
    end

    def call
      @args.reduce(self) do |acc, (name, args)|
        case args
        when Hash
          acc.send(name, **args)
        when Array
          acc.send(name, *args)
        end
      end
    end

    private

    def select_query(*args)
      self.class.new(@database, *args).call
    end

    # This method does not do any arity checking on rows.  The array zip
    # method drops superfluous tail values, as a result extra values are
    # ignored e.g.
    #   (foo, bar) VALUES (1, 2, 3)
    # would insert the row {foo: 1, bar: 2}
    def insert_into_query(schema_name: nil, table_name:, column_names:, rows:)
      table = @database.from(schema_name: schema_name, table_name: table_name)
      rows.each do |row|
        table.insert Hash[column_names.zip(row)]
      end
    end
  end
end
