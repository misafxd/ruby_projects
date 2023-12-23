class Node
  include Comparable
  attr_accessor :left, :right, :data

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def <=>(other)
    @data <=> other.data
  end
end

class Tree
  attr_accessor :root

  def initialize(array)
    @array = array.uniq.sort
    @root = build_tree(@array, 0, @array.size - 1)
  end

  def build_tree(array, start, final)
    return nil if start > final

    mid = (start + final) / 2
    root = Node.new(array[mid])
    root.left = build_tree(array, start, mid - 1)
    root.right = build_tree(array, mid + 1, final)
    root
  end

  def insert(value)
    @root = insert_value(@root, value)
  end

  def insert_value(root, value)
    return root = Node.new(value) if root.nil?

    if value < root.data
      root.left = insert_value(root.left, value)
    elsif value > root.data
      root.right = insert_value(root.right, value)
    end

    root
  end

  def delete(value)
    @root = delete_value(@root, value)
  end

  def delete_value(root, value)
    return root if root.nil?

    if root.data > value
      root.left = delete_value(root.left, value)
      return root
    elsif root.data < value
      root.right = delete_value(root.right, value)
      return root
    end

    if root.left.nil?
      temporal = root.right
      root = nil
      return temporal
    elsif root.right.nil?
      temporal = root.left
      root = nil
      return temporal
    else
      new_root = root
      root_replace = root.right
      until root_replace.left.nil?
        new_root = root_replace
        root_replace = root_replace.left
      end
    end

    if new_root != root
      new_root.left = root_replace.right
    else
      new_root.right = root_replace.right
    end

    root.data = root_replace.data
    root
  end

  def find(value, root = @root)
    return if root.nil?

    if root.data == value
      root
    elsif root.data > value
      find(value, root.left)
    elsif root.data < value
      find(value, root.right)
    end
  end

  def level_order(root = @root, array = [])
    return 'Empty' if root.nil?
    array.push(root)
    level_order_result = []

    until array.empty?
      current_node = array[0]
      level_order_result.push current_node.data
      array.shift
      array.push(current_node.left) unless current_node.left.nil?
      array.push(current_node.right) unless current_node.right.nil?
    end

    if block_given?
      level_order_result.each { |data| yield(data) }
    else
      level_order_result
    end
  end

  def preorder(root = @root, array = [])
    return 'Empty' if root.nil?
    array.push root.data
    preorder(root.left, array) if root.left
    preorder(root.right, array) if root.right

    if block_given?
      array.each { |data| yield(data)}
    else
      array
    end
  end

  def inorder(root = @root, array = [])
    return 'Empty' if root.nil?
    inorder(root.left, array) if root.left
    array.push(root.data)
    inorder(root.right, array) if root.right

    if block_given?
      array.each { |data| yield(data)}
    else
      array
    end
  end

  def postorder(root = @root, array = [])
    return 'Empty' if root.nil?
    postorder(root.left, array) if root.left
    postorder(root.right, array) if root.right
    array.push(root.data)

    if block_given?
      array.each { |data| yield(data)}
    else
      array
    end
  end

  def height(node_to_find)
    target_node = find(node_to_find)
    return 0 if target_node.nil?

    heights = Array.new(2) {0}
    current_node = target_node

    heights[0] += 1 while current_node = current_node.left || current_node.right
    heights[1] += 1 while target_node = target_node.right || target_node.left

    heights.max
  end

  def depth(value, root = @root)
    return -1 if root.nil?
    return 0 if root.data == value

    count = 0

    until root.data == value
      count += 1
      root = root.left if value < root.data
      root = root.right if value > root.data
    end

    count
  end

  def balanced?
    return false if @root.nil?
    return true if @root.data && @root.left.nil? && @root.right.nil?

    (height(@root.left.data) - height(@root.right.data)).between?(-1, 1)
  end

  def rebalance
    array = inorder(@root)
    @root = build_tree(array, 0, array.size - 1)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

# tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
# tree.pretty_print

tree_random = Tree.new(Array.new(15) { rand(1..100) })
tree_random.pretty_print
p tree_random.balanced?
p tree_random.level_order
p tree_random.preorder
p tree_random.postorder
p tree_random.inorder
9.times {tree_random.insert(rand(1..100))}
tree_random.pretty_print
p tree_random.balanced?
tree_random.rebalance
p tree_random.balanced?
p tree_random.level_order
p tree_random.preorder
p tree_random.postorder
p tree_random.inorder
tree_random.pretty_print
