# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'pollster/version'

Gem::Specification.new do |s|
  s.name = 'pollster-ruby'
  s.version = Pollster::VERSION
  s.summary = "Ruby library for accessing the Pollster API"
  s.description = "A Ruby library for accessing the Pollster API."

  s.files = `git ls-files`.split("\n")
  s.require_paths = ['lib']
end

