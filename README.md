# FactoryGirl::DependencyTree

a simple library for analyzing the dependencies between your factory_girl factories

## Description

This gem prints out all of the other factories that your factories call. It helps to reveal chains of factory calls that might be broken, unnecessary, or inefficient. For example, we had factory chains that would create users at multiple points causing inconsistencies (which we hacked around using callbacks to resync them). Since we've changed this we've seen some of our factories perform an order of magnitude better resulting in some tests running 50% faster.

## Installation

```rb
gem 'factory_girl-dependency_tree'
```

## Usage

The `::analyze!` method is an example for how this can be used. Here is a script you should be able to run with Rails depending on how complex your test environment is. It will output the dependency tree and warn you if there are any factories that are being called more than once.

```sh
rails runner "require 'factory_girl-depedency_tree'; FactoryGirl::DependencyTree.analyze!"
```

