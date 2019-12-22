require "test_helper"

module Rsql
  class ParserTest < Minitest::Test
    def parser
      @parser ||= Parser.new
    end

    def test_parse_select
      ast = parser.parse <<~SQL
        SELECT *, thing
        FROM my_table
        WHERE ( this=that OR foo = bar ) AND a=b;
      SQL
      puts ''
      puts ''
      p ast
    end
  end
end
