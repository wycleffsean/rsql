require "test_helper"

module Rsql
  class LexerTest < Minitest::Test
    def actual
      @tokens.map {|x, _| x }.reject {|x| x == :ws || x == :state }
    end

    def test_select_tokens
      @tokens = Lexer.lex <<~SQL
        SELECT *
        FROM my_table
        WHERE this=that;
      SQL
      expected = %i[
        kw_select star
        kw_from identifier
        kw_where identifier op_equal identifier semicolon
      ]
      assert_equal expected, actual
    end

    def test_create_table_tokens
      @tokens = Lexer.lex <<~SQL
        CREATE TABLE films (
          code        char(5) CONSTRAINT firstkey PRIMARY KEY,
          title       varchar(40) NOT NULL,
          did         integer NOT NULL,
          date_prod   date,
          kind        varchar(10),
          len         interval hour to minute
        );
      SQL
      expected = %i[
        kw_create kw_table identifier lparen
        identifier identifier lparen integer rparen kw_constraint identifier kw_primary kw_key comma
        identifier identifier lparen integer rparen kw_not kw_null comma
        identifier identifier kw_not kw_null comma
        identifier identifier comma
        identifier identifier lparen integer rparen comma
        identifier identifier identifier identifier identifier
        rparen semicolon
      ]
      assert_equal expected, actual
    end

    def test_insert_into_tokens
      @tokens = Lexer.lex <<~SQL
        INSERT INTO films (code, kind)
         VALUES ('T_601', 'Yojimbo');
      SQL
      expected = %i[
        kw_insert kw_into identifier lparen identifier comma identifier rparen
        kw_values lparen string comma string rparen semicolon
      ]
      assert_equal expected, actual
    end

    def test_op_or
      @tokens = Lexer.lex 'this OR that'
      expected = %i[identifier op_or identifier]
      assert_equal expected, actual
    end

    def test_op_and
      @tokens = Lexer.lex 'this AND that'
      expected = %i[identifier op_and identifier]
      assert_equal expected, actual
    end
  end
end
