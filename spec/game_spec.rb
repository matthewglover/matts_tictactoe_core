require "matts_tictactoe_core/game"

describe MattsTictactoeCore::Game do
  context "new game" do
    let(:game) { MattsTictactoeCore::Game.new(player_x_type: :human, player_o_type: :human) }
    
    it "has emtpy board" do
      expect(game.board).to eq(MattsTictactoeCore::Board.new)
    end
  end

  context "when player x moves" do
    let(:game) { MattsTictactoeCore::Game.new(player_x_type: :human, player_o_type: :human) }

    it "updates board with move provided" do
      game.next_move(1);
      expect(game.board).to eq(build_board(1))
    end
  end

  context "complete board" do
    let(:complete_board) { drawn_board }
    let(:game) { MattsTictactoeCore::Game.new(player_x_type: :human, player_o_type: :human, board: complete_board) }

    it "reports game is complete" do
      expect(game.complete?).to be true
    end
  end

  context "when next player is human" do
    let(:game) { MattsTictactoeCore::Game.new(player_x_type: :human, player_o_type: :human) }
    
    it "returns a simple human player" do
      expect(game.next_player).to be_a_kind_of(MattsTictactoeCore::HumanPlayer)
    end
  end

  context "when next player is computer" do
    let(:game) { MattsTictactoeCore::Game.new(player_x_type: :computer, player_o_type: :human) }

    it "returns a simple computer player" do
      expect(game.next_player).to be_a_kind_of(MattsTictactoeCore::ComputerPlayer)
    end
  end
end
