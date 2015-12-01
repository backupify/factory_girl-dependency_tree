# FactoryGirl::DependencyTree

a simple library for analyzing the dependencies between your factory_girl factories 

## Installation

```rb
gem 'factory_girl-dependency_tree'
```

## Usage

With Rails:

```sh
rails runner "require 'factory_girl-depedency_tree'; FactoryGirl::DependencyTree.analyze_dependencies!"
```

