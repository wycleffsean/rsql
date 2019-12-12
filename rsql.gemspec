
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rsql/version"

Gem::Specification.new do |spec|
  spec.name          = "rsql"
  spec.version       = Rsql::VERSION
  spec.authors       = ["Sean Carey"]
  spec.email         = ["wycleffsean@gmail.com"]

  spec.summary       = %q{in memory sql engine}
  # spec.description   = %q{}
  spec.homepage      = "https://github.com/wycleffsean/rsql"
  spec.license       = "MIT"

  included_globs = %w[lib/**/* *.gemspec exe/**/* Gemfile Rakefile README.md LICENSE.txt]
  spec.files         = Dir[*included_globs]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]


  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency 'oedipus_lex', '~> 2.5', '>= 2.5.1'
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
