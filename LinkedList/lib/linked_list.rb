# LinkedList represent the full list
class LinkedList
  def append(value)
    node = Node.new(value)
    if @head.nil?
      @head = node
    else
      @current_node = @head
      @current_node = @current_node.next_node while @current_node.next_node
      @current_node.next_node = node
    end
  end

  def prepend(value)
    node = Node.new(value)
    node.next_node = @head
    @head = node
  end

  def size
    iterate_over_linked_list
    @count
  end

  def head
    @head.value
  end

  def tail
    @current_node.next_node.value
  end

  def at(index)
    iterate_over_linked_list { return "Value at index #{index}: #{@current_node.value}" if @count == index }
  end

  def pop
    if @head.nil?
      puts 'Empty list'
    elsif @head.next_node.nil?
      @head = nil
    else
      @current_node = @head
      @current_node = @current_node.next_node while @current_node&.next_node&.next_node
    end
    @current_node.next_node = nil
  end

  def contains?(value)
    iterate_over_linked_list { return true if @current_node.value == value }
    false
  end

  def find(value)
    iterate_over_linked_list { return "Value #{value} at index: #{@count}" if @current_node.value == value }
    nil
  end

  def insert_at(value, index)
    node = Node.new(value)
    if index.zero?
      prepend(value)
    elsif index >= size
      append(value)
    else
      @current_node = @head
      (index - 1).times { @current_node = @current_node.next_node }
      node.next_node = @current_node.next_node
      @current_node.next_node = node
    end
  end

  def remove_at(index)
    if index.zero?
      @head = @head.next_node
    elsif index > size
      puts "index #{index} doesn't exist"
    else
      @current_node = @head
      (index - 1).times { @current_node = @current_node.next_node }
      @current_node.next_node = @current_node.next_node.next_node
    end
  end

  def iterate_over_linked_list
    @count = 0
    @current_node = @head
    while @current_node
      yield if block_given?
      @current_node = @current_node.next_node
      @count += 1
    end
  end

  def to_s
    if @head.nil?
      puts 'Empty list'
    else
      iterate_over_linked_list { print "[#{@current_node.value}] -> " unless @current_node.value.nil? }
    end
  end
end

# Create nodes
class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

list = LinkedList.new
list.append(5)
list.append(8)
list.append(6)
list.prepend(1)
list.prepend(2)
list.insert_at(3, 3)
list.remove_at(10)

p list.to_s
