require 'forwardable'

module Rsql
  class Query
    extend Forwardable

    def self.call(database, query_str)
      p = Parser.new
      sexp = p.parse(query_str)
      new(database, *sexp).call
    end

    def_delegators :@database, :from, :create_table

    def initialize(database, *args)
      @database = database
      @args = args
    end

    def call
      @args.reduce(self) do |acc, (name, args)|
        case args
        when Hash
          acc.send(name, **args)
        when Array
          acc.send(name, *args)
        end
      end
    end

    private

    def select_query(*args)
      self.class.new(@database, *args).call
    end
  end
end
