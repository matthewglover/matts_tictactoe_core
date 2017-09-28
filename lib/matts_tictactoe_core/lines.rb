module MattsTictactoeCore
  class Lines 
    def initialize(board)
      @board = board
    end

    def all
      rows + columns + diagonals
    end

    def rows
      (1..total_squares)
        .step(size)
        .map(&method(:row))
    end
    
    private
    def row(start)
      (start...start + size).to_a
    end

    def columns
      (1..size).map(&method(:column))
    end

    def column(start)
      ((start..total_squares).step(size)).to_a
    end

    def diagonals
      [diagonal_from_top_left, diagonal_from_top_right]
    end

    def diagonal_from_top_left
      (squares.step(size + 1)).to_a
    end

    def diagonal_from_top_right
      ((size...total_squares).step(size - 1)).to_a
    end

    def size
      @board.size
    end

    def total_squares
      @board.total_squares
    end

    def squares
      @board.squares
    end
  end
end
