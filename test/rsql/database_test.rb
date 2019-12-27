require "test_helper"

module Rsql
  class DatabaseTest < Minitest::Test
    def test_database_defaults
      db = Database.new
      assert_equal %i[public], db.schemas.keys
    end

    def test_create_table_with_default_schema
      db = Database.new
      table = db.create_table table_name: :test
      assert_kind_of Table, table
      assert_equal db.schemas[:public][:test], table
    end

    def test_create_table_with_schema
      db = Database.new
      schema = db.create_schema schema_name: :foo
      assert_kind_of Database::Schema, schema
      db.create_table schema_name: :foo, table_name: :test
      assert_kind_of Table, db.from(schema_name: :foo, table_name: :test)
    end

    def test_create_table_with_nonexistant_schema
      db = Database.new
      assert_raises(Database::SchemaNotPresentError) do
        db.create_table schema_name: :foo, table_name: :bar
      end
    end

    def test_from
      db = Database.new
      db.create_table table_name: :baz
      assert_kind_of Table, db.from(table_name: :baz)
      assert_kind_of Table, db.from(schema_name: :public, table_name: :baz)

      db.create_schema schema_name: :foo
      db.create_table schema_name: :foo, table_name: :bar
      assert_kind_of Table, db.from(schema_name: :foo, table_name: :bar)
    end

    def test_from_with_nonexistant_table
      db = Database.new
      assert_raises(Database::TableNotPresentError) do
        db.from table_name: :bar
      end

      db.create_schema schema_name: :foo
      assert_raises(Database::TableNotPresentError) do
        db.from schema_name: :foo, table_name: :bar
      end
    end

  end
end
