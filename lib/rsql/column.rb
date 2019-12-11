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

  def assert!(value)
    raise ConstraintViolationError if @params[:null] == false && value.nil?
  end

  def dump(value)
    raise NotImplementedError
  end

  def load(value)
    raise NotImplementedError
  end
end
