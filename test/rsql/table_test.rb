require "test_helper"

module Rsql
  class TableTest < Minitest::Test
    def setup
      @table = Table.new
    end

    def test_add_column_type_string
      @table.add_column :email, :string
      name, type = @table.columns.first
      assert_equal name, :email
      assert type.kind_of?(Column::String)
    end

    def test_add_column_type_text
      @table.add_column :email, :text
      name, type = @table.columns.first
      assert_equal name, :email
      assert_kind_of Column::String, type
    end

    def test_add_column_type_integer
      @table.add_column :age, :integer
      name, type = @table.columns.first
      assert_equal name, :age
      assert_kind_of Column::Integer, type
    end

    def test_add_column_type_int
      @table.add_column :age, :int
      name, type = @table.columns.first
      assert_equal name, :age
      assert_kind_of Column::Integer, type
    end

    def test_insert
      @table.add_column :email, :string
      @table.add_column :age, :integer, null: false
      @table.insert age: 30, email: 'dude@example.com'
    end

    def test_insert_with_invalid_columns
      assert_raises(Table::UnknownColumnError) do
        @table.insert foo: 30
      end
    end

    def test_insert_asserts_constraints
      @table.add_column :email, :string
      @table.add_column :age, :integer, null: false

      assert_raises(Column::ConstraintViolationError) do
        @table.insert email: 'dude@example.com' # not null constraint
      end

      assert_raises(Column::ConstraintViolationError) do
        @table.insert age: '30' # value constraint
      end

      assert_raises(Column::ConstraintViolationError) do
        @table.insert age: 30, email: 30 # value constraint
      end
    end

    def test_select_star
      @table.add_column :email, :string
      @table.add_column :age, :integer, null: false
      row = { age: 30, email: 'dude@example.com' }
      @table.insert row
      assert_equal @table.select.first, row
    end

    def test_select_column
      @table.add_column :email, :string
      @table.add_column :age, :integer, null: false
      @table.insert age: 30, email: 'dude@example.com'
      assert_equal @table.select(:age).first, { age: 30 }
    end

    def test_where
      @table.add_column :age, :integer, null: false
      @table.insert age: 30
      @table.insert age: 40
      assert_equal @table.where {|x| x[:age] > 30 }.length, 1
    end
  end
end
