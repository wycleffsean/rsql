require 'rsql/parser.tab'

module Rsql
  class ParseError < Racc::ParseError; end

  Parser.class_eval do
    def parse(str)
      @lexer = Lexer.lex(str).reject {|x, _| x == :ws || x == :state }.to_enum
      do_parse
    rescue Racc::ParseError => e
      raise ParseError, e.message
    end

    def next_token
      @lexer.next
    rescue StopIteration
      nil # [false false]
    end
  end
end
