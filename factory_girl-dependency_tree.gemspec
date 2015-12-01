# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'factory_girl/dependency_tree/version'

Gem::Specification.new do |spec|
  spec.name          = "factory_girl-dependency_tree"
  spec.version       = FactoryGirl::DependencyTree::VERSION
  spec.authors       = ["Josh Bodah"]
  spec.email         = ["jb3689@yahoo.com"]

  spec.summary       = %q{a simple library for analyzing the dependencies between your factory_girl factories}
  spec.homepage      = "https://github.com/backupify/factory_girl-dependency_tree"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'rubytree'
  spec.add_dependency 'factory_girl'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
