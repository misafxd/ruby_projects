# frozen_string_literal: true

require_relative '../Tic_tae_toe/tic_tac_toe'

RSpec.describe Game do
  let(:board) { Board.new }
  let(:player_x) { Player.new('X') }
  let(:player_o) { Player.new('O') }

  describe '#update_board' do
    let(:player_double) { instance_double(Player, symbol: 'X') }

    context 'when updating a cell with player symbol' do
      it 'updates the specified cell with the player symbol' do
        allow(player_double).to receive(:symbol).and_return('X')
        board.update_board([1, 1], player_double)
        expect(board.grid[1][1]).to eq('X')
      end
    end

    context 'when updating a cell with another player symbol' do
      it 'updates the specified cell with the other player symbol' do
        allow(player_double).to receive(:symbol).and_return('O')
        board.update_board([2, 2], player_double)
        expect(board.grid[2][2]).to eq('O')
      end
    end
  end

  describe '#won?' do
    context 'when all X are in the first row' do
      it 'returns true' do
        board.update_board([0, 0], player_x)
        board.update_board([0, 1], player_x)
        board.update_board([0, 2], player_x)
        expect(board.won?(player_x)).to be true
      end
    end

    context 'when there are no winning combinations' do
      it 'returns false' do
        expect(board.won?(player_x)).to be false
      end
    end
  end
end

describe Board do
  let(:board) { described_class.new }

  describe '#full?' do
    context 'when the board is not full' do
      it 'returns false' do
        allow(board).to receive_message_chain(:grid, :flatten, :none?).and_return(true)
        expect(board.full?).to be_falsy
      end
    end
  end
end
