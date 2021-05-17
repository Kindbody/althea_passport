# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "althea_passport/version"

Gem::Specification.new do |spec|
  spec.name          = "althea_passport"
  spec.version       = AltheaPassport::VERSION
  spec.authors       = ["Cody Sanders"]
  spec.email         = ["csanders2308@gmail.com"]

  spec.summary       = "This is a short summary."
  spec.homepage      = "http://genera.tions.io"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_dependency "http", ">= 4.4"
  spec.add_dependency "jwt", "~> 2.2"
end
