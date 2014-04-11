# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'jam/version'

Gem::Specification.new do |s|
  s.name = 'jam'
  s.version = Jam::VERSION
  s.date = '2014-04-11'
  s.summary = 'Library for game jamming/prototyping'
  s.description = 'Library for game jamming/prototyping.'
  s.authors = ['Tom Dalling']
  s.email = 'tom@tomdalling.com'
  s.files = Dir['lib/**/*', 'example/**/*']
  s.homepage = 'https://github.com/tomdalling/jam'
  s.license = 'Apache V2'

  s.add_runtime_dependency 'gosu', '~> 0.7'
  s.add_runtime_dependency 'activesupport', '~> 4.1'
  s.add_development_dependency 'byebug', '~> 2.7'
end
