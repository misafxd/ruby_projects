class Mastermind
  attr_accessor :code_size, :secret_code

  def initialize
    @code_size = 4
    @secret_code = Array.new(@code_size) { rand(1..8) }
    @guess_count = 0
    @tries_limit = 12
    # instructions
    # play
  end

  def instructions
    puts 'Welcome to Mastermind!!'
    puts "The computer has chosen #{@code_size} numbers between 1 to 8"
    puts "Or if you type y choose a #{@code_size} size secret code"
    puts 'You have 12 tries to guess the secret code'
    puts 'Numbers can be use multiple times'
    puts 'The computer will give you feedback for each guess'
    puts 'Correct number and position will be highlithed'
  end

  def input
    @input = gets.chomp.split('').map(&:to_i)
    if @input.size != 4
      puts 'The entry must have a length of 4'
      input
    end
    @input
  end

  def guess_code
    @guess_count += 1
    puts "Guess #{@guess_count}:"
    input
  end

  def correct_position
    @correct_position = 0
    @guess = @input.map { |n| n }
    @guess.each_with_index { |num, index| @correct_position += 1 if @secret_code[index] == num }
    puts "Correct position: #{@correct_position}"
  end

  def correct_guesses
    copy_secret = @secret_code.map { |n| n }
    index = 0
    @guess.each do |num|
      index = copy_secret.find_index(num)
      copy_secret.delete_at(index) if index
    end
    @correct_guesses = @code_size - copy_secret.size
    puts "Correct guesses: #{@correct_guesses}"
  end

  def won?
    if @correct_position == @code_size
      puts 'You win'
      puts "Secret code: #{@secret_code}"
      exit
    elsif @guess_count == @tries_limit
      puts 'you lose'
      puts "Secret code: #{@secret_code}"
      exit
    end
    play
  end

  def play
    guess_code
    correct_position
    correct_guesses
    won?
  end
end

class Player
  def initialize
    @game = Mastermind.new
    @game.instructions
    create_code
    @game.play
  end

  def create_code
    puts 'Do yo want set a secret code? [y/n]'
    if gets.chomp.downcase == 'y'
      puts "Type a #{@game.code_size} size secret code"
      puts 'Only numbers between 1 - 8 please'
      @game.secret_code = @game.input
      system('clear')
      @game.instructions
    else
      puts 'Crack the code!!'
    end
  end
end

Player.new
