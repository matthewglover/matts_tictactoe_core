require "matts_tictactoe_core/alpha_beta"
require "matts_tictactoe_core/mini_max"

describe "Unbeatable Computer" do
  context "one square remaining" do
    it "selects final square" do
      # x o x
      # x o o
      # 7 x o
      board = build_board(1, 2, 3, 5, 4, 6, 8, 9)
      assert_computer_move(board, 7)
    end
  end

  context "two squares remaining" do
    it "selects winning move over losing move" do
      # x o x
      # x o o
      # 7 8 x
      board = build_board(1, 2, 3, 5, 4, 6, 9)
      assert_computer_move(board, 8)
    end

    it "selects draw over losing move" do
      # o x o
      # x x o
      # 7 8 x
      board = build_board(2, 1, 4, 3, 5, 6, 9)
      assert_computer_move(board, 8)
    end
  end

  context "losing position" do
    it "selects move to delay losing" do
      # See http://neverstopbuilding.com/minimax (Smart/Dumb example for visualisation)
      
      # 1 x 3
      # 4 5 x
      # o o x
      board = build_board(2, 7, 6, 8, 9)
      assert_computer_move(board, 3)
    end
  end

  context "limit move search depth" do
    it "can effect the result" do
      # 1 x 3
      # 4 5 x
      # o o x
      board = build_board(2, 7, 6, 8, 9)
      assert_computer_move(board, 3, max_depth: 2)
      assert_computer_move(board, 1, max_depth: 1)
    end
  end

  context "speed comparison" do
    it "alpha_beta is faster than mini_max for multiple moves", speed: 'slow' do
      board = build_board(1, 4)
      alpha_beta_time, mini_max_time = assert_computer_move(board, 2)
      expect(alpha_beta_time).to be < mini_max_time
      expect(alpha_beta_time).to be < mini_max_time / 6
    end
  end

  def assert_computer_move(*args)
    run_assertions_with_time(*args).map { |(start_time, end_time)| end_time - start_time }    
  end

  def run_assertions_with_time(initial_board, result, options = {})
    [MattsTictactoeCore::AlphaBeta, MattsTictactoeCore::MiniMax].map do |algorithm|
      start_time = Time.now
      expect(algorithm.new(initial_board, options).execute.move).to eq(result)
      end_time = Time.now
      [start_time, end_time]
    end
  end
end
