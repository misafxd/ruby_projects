# frozen_literal_string: true
# rubocop:disable Metrics/BlockLength

require_relative '../connect_four/lib/connect_four'

describe ConnectFour do
  subject(:game) { described_class.new }

  describe '#column_drop' do
    context 'when the column is valid and not full' do
      it 'drops a player token into the column' do
        column = 1
        expect { game.column_drop(column) }.not_to raise_error
        expect(game.board[column].any? { |cell| cell == game.current_player }).to be true
      end
    end

    context 'when the column is invalid' do
      it 'raises an ArgumentError' do
        column = -1
        expect { game.column_drop(column) }.to raise_error(ArgumentError, 'Invalid column index')
      end
    end

    context 'when the column is full' do
      it 'raises an ArgumentError' do
        # Fill up the first column
        game.board[0] = Array.new(6, game.current_player)
        column = 0
        expect { game.column_drop(column) }.to raise_error(ArgumentError, 'Column is full')
      end
    end
  end

  describe '#won?' do
    context 'when a player has won vertically' do
      it 'returns true' do
        # Simulate a vertical win
        4.times { |i| game.board[0][i] = game.current_player }
        expect(game.won?).to be true
      end
    end

    context 'when a player has won horizontally' do
      it 'returns true' do
        # Simulate a horizontal win
        4.times { |i| game.board[i][0] = game.current_player }
        expect(game.won?).to be true
      end
    end

    context 'when a player has won diagonally' do
      it 'returns true' do
        # Simulate a diagonal win
        4.times { |i| game.board[i][i] = game.current_player }
        expect(game.won?).to be true
      end
    end
  end

  describe '#valid_column?' do
    context 'when the column is within bounds' do
      it 'returns true' do
        expect(game.valid_column?(0)).to be true
      end
    end

    context 'when the column is negative' do
      it 'returns false' do
        expect(game.valid_column?(-1)).to be false
      end
    end

    context 'when the column is greater than the board size' do
      it 'returns false' do
        expect(game.valid_column?(game.board.size)).to be false
      end
    end
  end

  describe '#column_not_full?' do
    context 'when the column has empty spaces' do
      it 'returns true' do
        expect(game.column_not_full?(0)).to be true
      end
    end

    context 'when the column is full' do
      it 'returns false' do
        # Fill up the first column
        game.board[0] = Array.new(6, game.current_player)
        expect(game.column_not_full?(0)).to be false
      end
    end
  end
end
