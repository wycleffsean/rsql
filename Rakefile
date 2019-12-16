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
  parser
  test
]

task :lexer => 'lib/rsql/lexer.rex.rb' do
  puts 'Building lexer'
end
task :parser => 'lib/rsql/parser.tab.rb'

file 'lib/rsql/parser.tab.rb' => 'lib/rsql/parser.y' do
  puts 'Building parser'
  `cd lib/rsql && racc -g parser.y`
end
