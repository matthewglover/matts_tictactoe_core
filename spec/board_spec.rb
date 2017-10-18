require "matts_tictactoe_core/board"

describe MattsTictactoeCore::Board do
  Board = MattsTictactoeCore::Board

  context "with explicit argument of size 4" do
    it "creates a 4x4 board" do
      board = Board.ofSize(4)
      expect(board.size).to eq(4)
    end
  end

  context "with explicit argument of size 3" do
    it "creates a 3x3 board" do
      board = Board.ofSize(3)
      expect(board.size).to eq(3)
    end
  end

  context "without explicit size argument" do
    it "creates a 3x3 board" do
      board = Board.new()
      expect(board.size).to eq(3)
    end
  end

  context "4x4 board" do
    it "move returns a 4x4 board" do
      board = Board.ofSize(4)
      next_board = board.move(10)
      expect(next_board.size).to eq(4)
    end

    it "line of 3 is not a winning line" do
      board = run_moves([1, 5, 2, 6, 3])
      expect(board.winner?).to be false
    end

    it "row of 4 is a winning line" do
      board = run_moves([1, 5, 2, 6, 3, 7, 4])      
      expect(board.winner?).to be true
      expect(board.winner).to be :x
    end

    it "column of 4 is a winning line" do
      board = run_moves([1, 2, 5, 3, 9, 4, 13])
      expect(board.winner?).to be true
      expect(board.winner).to be :x
    end

    it "diagonal of 4 is a winning line" do
      board = run_moves([4, 1, 7, 2, 10, 3, 13])
      expect(board.winner?).to be true
      expect(board.winner).to be :x
    end
    
    def run_moves(moves)
      moves.reduce(Board.ofSize(4)) { |board, square| board.move(square) }
    end
  end

  describe "#moves" do
    it "empty for new Board" do
      expect(build_board().moves).to eq([])
    end
  end

  describe "#move" do
    it "adds new move to end of move list" do
      expect(build_board(1).moves).to eq([1])
      expect(build_board(1, 2).moves).to eq([1, 2])
    end

    it "returns new Board instance (Board is immutable)" do
      boardA = build_board()
      boardB = boardA.move(1)
      expect(boardA).not_to eq(boardB)
      expect(boardA.moves).to eq([])
      expect(boardB.moves).to eq([1])
    end

    it "no change if move already taken" do
      board = build_board(1)
      expect(board.move(1)).to be board 
    end

    it "no change if move out of bounds" do
      board = build_board()
      expect(board.move(19)).to be board
    end
  end

  describe "#valid_move?" do
    it "true if square not taken" do
      expect(build_board().valid_move?(1)).to be true
    end

    it "false if square taken" do
      expect(build_board(1).valid_move?(1)).to be false
    end

    it "false if square out of bounds" do
      board = build_board()
      expect(board.valid_move?(0)).to be false
      expect(board.valid_move?(10)).to be false
    end
  end

  describe "#winner?" do
    it "false if no winning line" do
      expect(build_board().winner?).to be false 
    end
    
    it "true if winning row" do
      # X X X
      # O O 6
      # 7 8 9
      expect(build_board(1, 4, 2, 5, 3).winner?).to be true
    end

    it "true if winning column" do
      # X O O
      # X 5 6
      # X 8 9
      expect(build_board(1, 2, 4, 3, 7).winner?).to be true
    end

    it "true if winning diagonal" do
      # O X 3
      # X O 6
      # X 8 O
      expect(build_board(2, 1, 4, 5, 7, 9).winner?).to be true
    end
  end

  describe "winner" do
    it "nil if no winner" do
      expect(build_board().winner).to be nil
    end

    it ":o if o wins" do
      expect(build_board(1, 4, 2, 5, 9, 6).winner).to be :o 
    end

    it ":x if x wins" do
      expect(build_board(1, 4, 2, 5, 3).winner).to be :x 
    end
  end

  describe "complete?" do
    it "false if incomplete board and no winner" do
      expect(build_board.complete?).to be false
    end

    it "true if winner" do
      expect(build_board(1, 4, 2, 5, 3).complete?).to be true 
    end

    it "true if board full" do
      # x o x
      # x o x
      # o x o
      expect(build_board(1, 2, 3, 5, 4, 7, 6, 9, 8).complete?).to be true
    end
  end

  describe "#rows_as_square_numbers_and_statuses" do
    it "returns empty rows for empty board" do
      expect(build_board().rows_as_square_numbers_and_statuses).to eq([
        [[1, :empty], [2, :empty], [3, :empty]],
        [[4, :empty], [5, :empty], [6, :empty]],
        [[7, :empty], [8, :empty], [9, :empty]]
      ])
    end

    it "returns correct square statuses" do
      expect(build_board(1, 4, 2, 8, 3).rows_as_square_numbers_and_statuses).to eq([
        [[1, :x], [2, :x], [3, :x]],
        [[4, :o], [5, :empty], [6, :empty]],
        [[7, :empty], [8, :o], [9, :empty]]
      ])
    end
  end

  describe "#next_player" do
    it ":x for empty board" do
      expect(build_board().next_player).to be :x
    end

    it ":o after first move" do
      expect(build_board(1).next_player).to be :o
    end

    it ":x after second move" do
      expect(build_board(1, 2).next_player).to be :x
    end
  end

  describe "#==" do
    it "equal when moves are the same" do
      expect(build_board(1, 2, 3)).to eq(build_board(1, 2, 3))
    end

    it "not equal when moves are different" do
      expect(build_board(1)).not_to eq(build_board)
    end
  end

  describe "empty_squares" do
    it "returns array of empty square numbers" do
      expect(build_board.empty_squares).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9])
    end

    it "returns empty array when board complete" do
      expect(drawn_board.empty_squares).to eq([])
    end
  end
end
