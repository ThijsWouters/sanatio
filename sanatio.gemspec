# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sanatio/version'

Gem::Specification.new do |spec|
  spec.name          = "sanatio"
  spec.version       = Sanatio::VERSION
  spec.authors       = ["Thijs Wouters"]
  spec.email         = ["thijs@morewood.be"]

  spec.summary       = "A gem for validation, without all the dependencies."
  spec.homepage      = "https://github.com/ThijsWouters/sanatio"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
