# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'open_badges/version'

Gem::Specification.new do |gem|
  gem.name          = "open_badges"
  gem.version       = OpenBadges::VERSION
  gem.authors       = ["Eric Allam"]
  gem.email         = ["rubymaverick@gmail.com"]
  gem.description   = %q{Work with OpenBadges Issuer API}
  gem.summary       = %q{Work with OpenBadges Issuer API}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "activesupport", "~> 3.0"

  gem.add_development_dependency "rspec", "2.14.0"
  gem.add_development_dependency "timecop", "0.4.5"
end
