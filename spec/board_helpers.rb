require "matts_tictactoe_core/board"

module BoardHelpers
  def build_board(*squares)
    squares.reduce(MattsTictactoeCore::Board.new) { |board, square| board.move(square) }
  end

  def drawn_board
    build_board(1, 2, 3, 4, 6, 5, 7, 9, 8)
  end

  def o_winning_board
    build_board(1, 4, 2, 5, 9, 6)
  end

  def x_winning_board
    build_board(1, 4, 2, 5, 3)
  end
end
