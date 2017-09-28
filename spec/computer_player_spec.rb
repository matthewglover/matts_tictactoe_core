require "matts_tictactoe_core/computer_player"
require "matts_tictactoe_core/alpha_beta"
require "matts_tictactoe_core/board"

describe MattsTictactoeCore::ComputerPlayer do
  let(:player) { MattsTictactoeCore::ComputerPlayer.new(max_depth: 1) }

  it "has type of :computer" do
    expect(player.type).to be :computer
  end

  context "with new board" do
    let(:board) { MattsTictactoeCore::Board.new }
    let(:alpha_beta_move) { MattsTictactoeCore::AlphaBeta.new(board, max_depth: 1) }

    it "makes same move as AlphaBeta algorithm" do
      expect(player.get_move(board)).to eq(alpha_beta_move.execute.move)
    end
  end
end
