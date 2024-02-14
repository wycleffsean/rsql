module Rsql
  class Column::Integer < Rsql::Column
    def initialize(**params)
      params[:max] ||= Float::INFINITY
      params[:limit] = (params[:min]..params[:max]) if params.has_key?(:min)
      params[:limit] ||= params[:max]
      super
    end

    def assert!(column_name = '...', value)
      super
      raise Column::ConstraintViolationError unless value.is_a?(::Integer)

      limit_exceeded = case limit = @params[:limit]
                       when Range
                         !limit.include?(value)
                       when Numeric
                         limit <= value
                       else false
                       end
      raise Column::ConstraintViolationError if limit_exceeded
    end
  end
end
