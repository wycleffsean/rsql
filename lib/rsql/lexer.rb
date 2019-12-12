class Rsql::Lexer
  require 'rsql/lexer.rex'

  def self.lex(str)
    lexer = new
    lexer.ss = lexer.scanner_class.new str
    Enumerator.new do |y|
      until (token = lexer.next_token).nil?
        y << token
      end
    end
  end
end
