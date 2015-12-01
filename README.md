# FactoryGirl::DependencyTree

a simple library for analyzing the dependencies between your factory_girl factories 

## Installation

```rb
gem 'factory_girl-dependency_tree'
```

## Usage

The `::analyze!` method is an example for how this can be used. Here is a script you should be able to run with Rails depending on how complex your test environment is. It will output the dependency tree and warn you if there are any factories that are being called more than once.

```sh
rails runner "require 'factory_girl-depedency_tree'; FactoryGirl::DependencyTree.analyze!"
```

