require "matts_tictactoe_core/human_player"

describe MattsTictactoeCore::HumanPlayer do
  let(:player) { MattsTictactoeCore::HumanPlayer.new }

  it "has player type of :human" do
    expect(player.type).to be :human
  end
end
