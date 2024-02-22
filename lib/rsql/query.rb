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
    #
    # Also INSERT INTO ... SELECT ... FROM is order agnostic, e.g.
    #   INSERT INTO thing(foo, bar) SELECT bar, foo FROM other_thing;
    # will correctly match column names
    def insert_into_query(table_name:, column_names:, schema_name: nil, rows: [], select_query: nil)
      # TODO: column_names can be nil, raise an error i.e. INSERT INTO things() VALUES (); is not a valid query
      target_table = @database.from(schema_name: schema_name, table_name: table_name)
      source_table = if select_query.nil?
                       Table.new rows: rows.map { |row| Hash[column_names.zip(row)] }
                     else
                       select_query(*select_query)
                     end
      source_table.map do |row|
        target_table.insert row
      end
      source_table
    end
  end
end
