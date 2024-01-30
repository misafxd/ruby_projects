# frozen_literal_string: true

class ConnectFour
  attr_accessor :board, :current_player

  def initialize(columns = 7, rows = 6)
    @board = Array.new(columns) { Array.new(rows) }
    @player1 = "\e[31m●\e[0m"
    @player2 = "\e[32m●\e[0m"
    @current_player = @player1
  end

  def column_drop(column)
    raise ArgumentError, 'Invalid column index' unless valid_column?(column)

    row = next_available_row(column)

    if row
      @board[column][row] = @current_player
    else
      raise ArgumentError, 'Column is full'
    end
  end

  def input(player = @current_player)
    puts "Player #{player}, choose a column (1 to #{@board.size}):"
    column = gets.chomp.to_i - 1

    until valid_column?(column) && column_not_full?(column)
      puts "Invalid choice. Please choose a valid and non-full column (1 to #{@board.size}):"
      column = gets.chomp.to_i - 1
    end

    column
  end

  def display_board
    puts '   1   2   3   4   5   6   7'
    puts ' ┌───┬───┬───┬───┬───┬───┬───┐'

    @board.transpose.to_enum.with_index.reverse_each do |row, index|
      row_display = row.map { |cell| cell.nil? ? '   ' : " #{cell} " }.join('|')
      puts "#{index + 1}│#{row_display}│"
    end

    puts ' └───┴───┴───┴───┴───┴───┴───┘'
  end

  def won?(board = @board)
    rows = board.length
    cols = board[0].length

    (0...rows).each do |row|
      (0..cols - 4).each do |col|
        return true if (col...col + 4).all? { |c| board[row][c] == @current_player }
      end
    end

    (0...cols).each do |col|
      (0..rows - 4).each do |row|
        return true if (row...row + 4).all? { |r| board[r][col] == @current_player }
      end
    end

    (3...rows).each do |row|
      (0..cols - 4).each do |col|
        return true if (0..3).all? { |i| board[row - i][col + i] == @current_player }
      end
    end

    (0...rows - 3).each do |row|
      (0..cols - 4).each do |col|
        return true if (0..3).all? { |i| board[row + i][col + i] == @current_player }
      end
    end

    false
  end

  def new_game
    display_instructions
    loop do
      display_board
      column_drop(input)
      break if full?
      break if won?

      switch_players
    end
    game_end_message
    display_board
  end

  def display_winner
    puts "Player #{@current_player} won!!"
  end

  def game_end_message
    if won?
      puts "Player #{@current_player} won!!"
    else
      puts "It's a tie!!"
    end
  end

  def display_instructions
    puts <<~INSTRUCTIONS
      \e[32mCONNECT FOUR\e[0m

      Welcome to Connect Four! The rules are simple:

      1. The game is played on a vertical grid with 7 columns and 6 rows.
      2. Two players take turns dropping their colored discs from the top into any of the seven columns.
      3. The disc will fall to the lowest available space in the selected column.
      4. The goal is to connect four of one's own discs vertically, horizontally, or diagonally before your opponent.
      5. The game ends when one player achieves a Connect Four or the grid is full (a tie).

      Player 1: #{@player1} Player 2: #{@player2}
      ------------------------------------
    INSTRUCTIONS
  end

  def valid_column?(column)
    column >= 0 && column < @board.size
  end

  def next_available_row(column)
    @board[column].index(nil)
  end

  def switch_players
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def column_not_full?(column)
    @board[column].include?(nil)
  end

  def full?
    !@board.flatten.include?(nil)
  end
end

# game = ConnectFour.new
# game.new_game
