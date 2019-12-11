require "test_helper"

module Rsql
  class ColumnTest < Minitest::Test
    def setup
      @klass = Column
    end

    def test_null
      constraint = @klass.new null: false
      assert_raises(Column::ConstraintViolationError) do
        constraint.assert! nil
      end
    end
  end
end
