require 'monitor'

module Rsql
  class Sequence
    include MonitorMixin

    def initialize(starting_value = 0)
      @value = starting_value
      super() # formatting important here
    end

    def next!
      synchronize do
        @value = @value.succ
      end
    end
  end
end
