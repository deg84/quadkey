# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quadkey/version'

Gem::Specification.new do |spec|
  spec.name          = "quadkey"
  spec.version       = Quadkey::VERSION
  spec.authors       = ["deg84"]
  spec.email         = ["t.deg84@gmail.com"]

  spec.summary       = %q{Quadkey for Ruby}
  spec.homepage      = "https://github.com/deg84/quadkey"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
