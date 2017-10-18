require "matts_tictactoe_core/game"

describe MattsTictactoeCore::Game do
  Game = MattsTictactoeCore::Game
  Board = MattsTictactoeCore::Board
  
  context "new game" do
    let(:game) { Game.new(player_x_type: :human, player_o_type: :human) }
    
    it "has emtpy 3x3 board" do
      expect(game.board).to eq(Board.ofSize(3))
    end
  end

  context "new 4x4 game" do
    let(:game) { Game.new(board_size: 4, player_x_type: :human, player_o_type: :human) }
    
    it "has emtpy 4x4  board" do
      expect(game.board).to eq(Board.ofSize(4))
    end
  end

  context "when player x moves" do
    let(:game) { Game.new(player_x_type: :human, player_o_type: :human) }

    it "updates board with move provided" do
      game.next_move(1);
      expect(game.board).to eq(build_board(1))
    end
  end

  context "complete board" do
    let(:complete_board) { drawn_board }
    let(:game) { Game.new(player_x_type: :human, player_o_type: :human, board: complete_board) }

    it "reports game is complete" do
      expect(game.complete?).to be true
    end
  end

  context "when next player is human" do
    let(:game) { Game.new(player_x_type: :human, player_o_type: :human) }
    
    it "returns a simple human player" do
      expect(game.next_player).to be_a_kind_of(MattsTictactoeCore::HumanPlayer)
    end
  end

  context "when next player is computer" do
    let(:game) { Game.new(player_x_type: :computer, player_o_type: :human) }

    it "returns a simple computer player" do
      expect(game.next_player).to be_a_kind_of(MattsTictactoeCore::ComputerPlayer)
    end
  end
end
