# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "munich"
  s.version     = '0.0.1'
  s.authors     = ["Victor Lin"]
  s.email       = ["victorhlin@gmail.com"]
  s.homepage    = "http://github.com/wonnage/munich"
  s.summary     = "Munich(ecker) - NextBus API gem"
  s.description = "A ruby library for the NextBus API."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency 'faraday'
  s.add_dependency 'faraday_middleware', '~> 0.9'
  s.add_dependency 'multi_xml'
  s.add_dependency 'geokit'
end
