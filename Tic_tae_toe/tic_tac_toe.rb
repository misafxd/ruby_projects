#  Board model
class Board
  attr_accessor :grid
  @@positions_available = {
    1 => [0, 0],
    2 => [0, 1],
    3 => [0, 2],
    4 => [1, 0],
    5 => [1, 1],
    6 => [1, 2],
    7 => [2, 0],
    8 => [2, 1],
    9 => [2, 2]
  }

  def initialize
    @grid = Array.new(3) { Array.new(3) }
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |_, column_index|
        @grid[row_index][column_index] = ' '
      end
      row
    end
  end

  def display
    puts ' '
    puts " #{grid[0][0]} | #{grid[0][1]} | #{grid[0][2]} "
    puts '---+---+---'
    puts " #{grid[1][0]} | #{grid[1][1]} | #{grid[1][2]} "
    puts '---+---+---'
    puts " #{grid[2][0]} | #{grid[2][1]} | #{grid[2][2]} "
    puts ' '
  end

  def update_board(index, player)
    row = index[0]
    column = index[1]
    @grid[row][column] = player.symbol
  end

  def full?
    @grid.flatten.none? { |cell| cell == ' ' }
  end

  def free_cell?(position)
    if @@positions_available.include?(position)
      @@positions_available.delete(position)
    else
      puts 'Ouch!! Cell not available, try again...'
    end
  end

  def won?(player)
    winning_combinations = [
      [grid[0][0], grid[0][1], grid[0][2]],
      [grid[1][0], grid[1][1], grid[1][2]],
      [grid[2][0], grid[2][1], grid[2][2]],
      [grid[0][0], grid[1][0], grid[2][0]],
      [grid[0][1], grid[1][1], grid[2][1]],
      [grid[0][2], grid[1][2], grid[2][2]],
      [grid[0][0], grid[1][1], grid[2][2]],
      [grid[0][2], grid[1][1], grid[2][0]]
    ]
    winning_combinations.any? do |combination|
      combination.all? { |cell| cell == player.symbol }
    end
  end
end

class Player
  attr_accessor :symbol

  def initialize(symbol)
    @symbol = symbol
  end
end

class Game
  attr_accessor :board, :player1, :player2

  def initialize
    @board = Board.new
    @player1 = Player.new('X')
    @player2 = Player.new('O')
    @current_player = @player1
  end

  def instructions
    puts 'TIC, TAC, TOE!!'
    puts 'Player 1 plays X - Player 2 plays O'
    puts 'Instructions: choose a cell (1-9)'
    puts ' 1 | 2 | 3 '
    puts ' 4 | 5 | 6 '
    puts ' 7 | 8 | 9 '
  end

  def get_input
    loop do
      input = gets.chomp.to_i
      @position = @board.free_cell?(input)
      break if @position.instance_of?(Array)
    end
  end

  def play
    loop do
      puts "Player #{@current_player.symbol} turn, choose a cell: "
      get_input
      @board.update_board(@position, @current_player)
      @board.display
      display_winner
      break if @board.won?(@current_player)
      break if @board.full?
      @current_player = @current_player == @player1 ? @player2 : @player1
    end
  end

  def display_winner
    if @board.won?(@current_player)
      puts "Player #{@current_player.symbol} wins!"
    elsif @board.full?
      puts "\nIt's a Tie!!"
    end
  end
end
# new_game = Game.new
# new_game.instructions
# new_game.board.display
# new_game.play
