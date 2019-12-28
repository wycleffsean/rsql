class Rsql::Column
  require 'rsql/column/string'
  require 'rsql/column/integer'

  class ConstraintViolationError < StandardError
  end

  DEFAULTS = {
    null: true,
  }.freeze

  def initialize(**params)
    @params = DEFAULTS.merge(params)
  end

  def assert!(column_name = '...', value)
    if @params[:null] == false && value.nil?
      raise ConstraintViolationError, "null value in column \"#{column_name}\" violates not-null constraint"
    end
  end

  def dump(value)
    raise NotImplementedError
  end

  def load(value)
    raise NotImplementedError
  end
end
