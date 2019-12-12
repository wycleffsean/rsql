#require 'rubygems'
require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

Rake.application.rake_require 'oedipus_lex'

task :default => %i[
  lexer
  test
]

task :lexer => 'lib/rsql/lexer.rex.rb'
