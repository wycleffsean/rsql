require "test_helper"

module Rsql
  class QueryTest < Minitest::Test
    def test_query
      res = Query.call <<-SQL
        SELECT email FROM people WHERE age >= 30;
      SQL
      p res
    end
  end
end
