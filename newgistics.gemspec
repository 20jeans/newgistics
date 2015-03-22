# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'newgistics/version'

Gem::Specification.new do |spec|
  spec.name          = "newgistics"
  spec.version       = Newgistics::VERSION
  spec.authors       = ["brianthecoder"]
  spec.email         = ["brian@dstld.la"]
  spec.summary       = %q{A client for integrating with the newgistics api}
  spec.description   = %q{A client for the newgistics api. Most functionality is supported around creating and tracking packages. Inventory and product management are supported as well}
  spec.homepage      = "https://github.com/20jeans/newgistics"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activemodel"
  spec.add_dependency "activesupport"
  spec.add_dependency "dotenv"
  spec.add_dependency "faraday_middleware"
  spec.add_dependency "nokogiri"
  spec.add_dependency "slim"
  spec.add_dependency "tilt"
  spec.add_dependency "virtus"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "ffaker"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "yard"
end
