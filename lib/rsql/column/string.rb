module Rsql
  class Column::String < Rsql::Column
    def initialize(**params)
      @params = params
    end

    def assert!(value)
      super
      raise Column::ConstraintViolationError unless value.kind_of?(::String)
      if !@params[:limit].nil? && value.length >= @params[:limit]
        raise Column::ConstraintViolationError
      end
    end
  end
end
