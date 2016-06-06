# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubycnab240/version'

Gem::Specification.new do |spec|
  spec.name          = "rubycnab240"
  spec.version       = RubyCnab240::VERSION
  spec.authors       = ["Gabriel Hamdan"]
  spec.email         = ["ghamdan.eng@gmail.com"]

  spec.summary       = "Crie arquivo de remessa de pagamentos CNAB240 - Febraban"
  spec.description   = "Crie arquivo de remessa de pagamentos CNAB240 - Febraban"
  spec.homepage      = "https://github.com/Hamdan85/rubycnab240"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
