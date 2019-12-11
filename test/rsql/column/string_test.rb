require "test_helper"
require "rsql/column_test"

module Rsql
  class Column::StringTest < ColumnTest
    def setup
      @klass = Column::String
    end

    def test_value_type
      constraint = @klass.new
      assert_raises(Column::ConstraintViolationError) do
        constraint.assert! 5
      end
    end

    def test_limit
      constraint = @klass.new limit: 5
      assert_nil constraint.assert!('yo')
      assert_raises(Column::ConstraintViolationError) do
        constraint.assert!('yoyoyo')
      end
    end
  end
end
