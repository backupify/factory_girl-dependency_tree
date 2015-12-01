require 'factory_girl/dependency_tree/version'
require 'tree'

module FactoryGirl
  module DependencyTree
    %i{create build build_stubbed attributes_for build_list create_list build_pair create_pair}.each do |sym|
      define_method(sym) do |*args, &block|
        FactoryGirl::DependencyTree.record("#{sym}##{args.first}") do
          super *args, &block
        end
      end
    end

    class << self
      # Example method for kicking off a sample dependency analysis
      # You should load your environment before calling this (e.g.
      # use `rails runner`)
      def analyze!
        # Install
        FactoryGirl.singleton_class.prepend(FactoryGirl::DependencyTree)

        # Run
        FactoryGirl.find_definitions if FactoryGirl.factories.none?
        FactoryGirl.factories.map(&:name).each do |f|
          begin
            FactoryGirl.create(f)
          rescue => e
            puts "Couldn't analyze factory #{f} due to #{e}"
          end
        end

        # Report
        puts "Printing the dependency tree of each FactoryGirl factory..."
        FactoryGirl::DependencyTree.forest.each do |t| 
          t.print_tree(t.node_depth, nil, -> (n, pre) { puts "#{pre} #{n.content}" }) 
        end

        puts '***'

        puts "Printing the FactoryGirl factories with more than one call to another single factory..."
        FactoryGirl::DependencyTree.forest.each do |tree|
          children = tree.each.to_a[1..-1]
          child_counts = children.map(&:content).reduce(Hash.new(0)) {|c,n| c[n] += 1; c} 
          puts "===\n#{tree.content}\n#{child_counts}" if child_counts.values.any? {|v| v > 1}
        end
      end

      def record(name)
        if @node
          node = Tree::TreeNode.new(SecureRandom.uuid, name)
          @node << node
          @node = node
        else
          @node = Tree::TreeNode.new(SecureRandom.uuid, name)
          forest << @node
        end
        yield.tap { @node = @node.parent }
      rescue => e
        @node = nil
        raise e
      end

      def forest
        @forest ||= []
      end
    end
  end
end
