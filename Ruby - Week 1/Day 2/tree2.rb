puts 'hello, world'
puts #prints empty line

class Tree
    attr_accessor :children, :node_name

    def initialize(hash={})
        # puts hash.to_s
        # puts hash.values
        @children = []
        # Top level entry will be a single key-value pair
        # Flatten the value to obtain an array with all key-value pairs in the value[0]
        # Use each slice to take two values at a time (the key-value pair)
        # to_h needs an array in an array to work, eg, [['a', 'b']]
        hash.values[0].flatten.each_slice(2) { |el| @children.push( Tree.new( [el].to_h ) ) } if hash.values[0]
        @node_name = hash.keys[0]
    end

    def visit_all(&block)
        visit &block
        children.each { |c| c.visit_all &block }
    end

    def visit(&block)
        block.call self
    end
end

ruby_tree = Tree.new( {
    'grandpa' => {
        'dad' => {
            'child 1' => {},
            'child 2' => {}
        },
        'uncle' => {
            'child 3' => {},
            'child 4' => {}
        }
    }
} )

puts "Visiting a node"
ruby_tree.visit { |node| puts node.node_name }
puts #prints empty line

puts "visiting entire tree"
ruby_tree.visit_all { |node| puts node.node_name }