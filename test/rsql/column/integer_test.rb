require "test_helper"
require "rsql/column_test"

module Rsql
  class Column::IntegerTest < ColumnTest
    def setup
      @klass = Column::Integer
    end

    def test_value_type
      constraint = @klass.new
      assert_raises(Column::ConstraintViolationError) do
        constraint.assert! '5'
      end
    end

    def test_limit
      constraint = @klass.new limit: 5
      assert_nil constraint.assert! 4
      assert_raises(Column::ConstraintViolationError) do
        constraint.assert! 6
      end
    end

    def test_limit_range
      constraint = @klass.new limit: (5..10)
      assert_nil constraint.assert! 6
      assert_raises(Column::ConstraintViolationError) do
        constraint.assert!(11)
      end
    end

    def test_limit_max
      constraint = @klass.new max: 5
      assert_nil constraint.assert! 4
      assert_raises(Column::ConstraintViolationError) do
        constraint.assert! 6
      end
    end

    def test_limit_min
      constraint = @klass.new min: 5
      assert_nil constraint.assert! 6
      assert_raises(Column::ConstraintViolationError) do
        constraint.assert! 4
      end
    end

  end
end
