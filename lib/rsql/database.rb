require 'forwardable'

module Rsql
  class Database
    class SchemaNotPresentError < StandardError; end
    class TableNotPresentError < StandardError; end

    class Schema
      extend Forwardable
      def_delegators :@tables, :[], :[]=, :has_key?, :fetch

      def initialize(tables: {})
        @tables = tables
      end
    end

    attr_reader :name, :schemas

    def initialize(**options)
      @name = options.fetch(:name, 'main')
      @search_path = options.fetch(:search_path, [:public])
      @schemas = options.fetch(:schemas) do
        { public: Schema.new }
      end
    end

    def create_schema(schema_name:, **args)
      schemas[schema_name] = Schema.new(**args)
    end

    def create_table(table_name:, schema_name: nil, **args)
      fetch_schema(schema_name)[table_name] = Table.new(**args)
    end

    def from(table_name:, schema_name: nil)
      schema = fetch_schema(schema_name) { |s| s.has_key?(table_name) }
      raise TableNotPresentError, "relation \"#{table_name}\" does not exist" if schema.nil?

      schema.fetch(table_name) do
        raise TableNotPresentError, "relation \"#{table_name}\" does not exist on schema \"#{schema_name}\""
      end
    end

    private

    def fetch_schema(schema_name, &block)
      unless schema_name.nil?
        schemas.fetch(schema_name) do
          raise SchemaNotPresentError, "schema \"#{schema_name}\" does not exist"
        end
      end

      default_schemas = schemas.values_at(*@search_path).compact
      if block_given?
        default_schemas.find(&block)
      else
        default_schemas.first
      end
    end
  end
end
