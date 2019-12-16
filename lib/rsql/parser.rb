require_relative './parser.tab.rb'

module Rsql
  Parser.class_eval do
    BinaryOp = Struct.new(:left, :operator, :right)
    def parse(str)
      @lexer = Lexer.lex(str).reject {|x, _| x == :ws || x == :state }.to_enum
      do_parse
    end

    def next_token
      @lexer.next
    rescue StopIteration
      nil
    end
  end
end
