# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'pollster/version'

Gem::Specification.new do |s|
  s.name = 'pollster'
  s.version = Pollster::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Jay Boice", "Aaron Bycoffe", "Andrei Scheinkman"]
  s.email = ["jay.boice@huffingtonpost.com", "bycoffe@huffingtonpost.com"]
  s.homepage = "http://github.com/huffpostdata/ruby-pollster"
  s.summary = "Ruby library for accessing the Pollster API"
  s.description = "A Ruby library for accessing the Pollster API."

  s.files = `git ls-files`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency 'json'

  s.add_development_dependency "rdoc"
end

