class Tree
  attr_accessor :value, :left, :right
  def initialize(value, left=nil, right=nil)
    @value = value
    @left = left
    @right = right
  end
  def each_node(&blk)
    blk.call value
    if (left != nil)
      left.each_node &blk
    end
    if (right != nil)
      right.each_node &blk
    end
  end
  def method_missing(m)
    array = m.to_s.split("_")
    result = nil
    tempnode = self
    for i in (0..array.length)
      tempnode = array[i].to_sym
      puts tempnode.value
    end
  end
end

my_tree = Tree.new(42,
                   Tree.new(3,
                            Tree.new(1,
                                     Tree.new(7,
                                              Tree.new(22),
                                              Tree.new(123)),
                                     Tree.new(32))),
                   Tree.new(99,
                            Tree.new(81)))
my_tree.each_node do |v|
  puts v
end

arr = []
my_tree.each_node do |v|
  arr.push v
end
p arr

p "Getting nodes from tree"
p my_tree.left
p my_tree.right_left
p my_tree.left_left_right
p my_tree.left_left_left_right

