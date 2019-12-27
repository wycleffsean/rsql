require "rsql/version"
require "rsql/ext/hash"

module Rsql
  require "rsql/table"
  autoload :Database, "rsql/database"
  autoload :Lexer, "rsql/lexer"
  autoload :Parser, "rsql/parser"
  autoload :Query, "rsql/query"
end
