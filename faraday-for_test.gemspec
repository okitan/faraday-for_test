# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "faraday-for_test"
  spec.version       = File.read(File.expand_path("VERSION", File.dirname(__FILE__))).chomp
  spec.authors       = ["okitan"]
  spec.email         = ["okitakunio@gmail.com"]

  spec.summary       = "convinient functions for api test"
  spec.description   = "convinient functions for api test"
  spec.homepage      = "https://github.com/okitan/faraday-for_test"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", ">= 0.8"
  spec.add_dependency "rack"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"

  # debub
  spec.add_development_dependency "pry"
  spec.add_development_dependency "tapp"
end
