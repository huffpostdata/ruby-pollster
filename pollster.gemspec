$:.push File.expand_path("../lib", __FILE__)
require "pollster/version"

Gem::Specification.new do |s|
  s.name        = "pollster"
  s.version     = Pollster::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Adam Hooper"]
  s.email       = ["adam.hooper@huffingtonpost.com"]
  s.homepage    = "https://github.com/huffpostdata/ruby-pollster"
  s.summary     = "Pollster API Ruby Gem"
  s.description = "Download election-related polling data from Pollster."
  s.license     = "CC-BY-NC-SA-3.0"
  s.required_ruby_version = ">= 1.9"

  s.add_runtime_dependency 'typhoeus', '~> 1.0', '>= 1.0.1'
  s.add_runtime_dependency 'ruby-immutable-struct', '~> 1.0', '>= 1.0.1'

  s.files         = `find *`.split("\n").uniq.sort.select{|f| !f.empty? }
  s.test_files    = `find spec/*`.split("\n")
  s.executables   = []
  s.require_paths = ["lib"]
end
