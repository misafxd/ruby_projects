# create nodes for tree-search
class ChessNode
  attr_accessor :position, :possible_moves, :parent

  def initialize(position, parent = nil)
    @position = position
    @possible_moves = moves(position)
    @parent = parent
  end

  def moves(position)
    legal_moves = []
    movements = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, -2], [-1, -2], [1, 2], [-1, 2]]
    movements.each do |move|
      x = position[0] + move[0]
      y = position[1] + move[1]
      legal_moves.push([x, y]) if x.between?(0, 7) && y.between?(0, 7)
    end
    legal_moves
  end

  def self.knight_move(initial_position, final_position)
    visited = Set.new([initial_position])
    queue = [ChessNode.new(initial_position)]
    until queue.empty?
      current_node = queue.shift
      return construct_path(current_node) if current_node.position == final_position

      current_node.possible_moves.each do |move|
        next if visited.include?(move)

        child_node = ChessNode.new(move, current_node)
        queue.push(child_node)
        visited.add(move)
      end
    end
  end

  def self.construct_path(node)
    path = []
    while node
      path.unshift(node.position)
      node = node.parent
    end
    p path
  end
end

ChessNode.knight_move([4, 3], [0, 7])
