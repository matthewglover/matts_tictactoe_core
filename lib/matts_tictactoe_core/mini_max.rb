module MattsTictactoeCore 
    
  class MiniMax 

    DRAWING_SCORE = OUT_OF_DEPTH_SCORE = 0
    INITIAL_DEPTH = 0

    attr_accessor :move, :score
    attr_reader :is_maximising

    def initialize(initial_board, options = {})
      @initial_board = initial_board
      @depth = options.fetch(:depth, INITIAL_DEPTH) 
      @is_maximising = options.fetch(:is_maximising, true)
      @max_depth = options.fetch(:max_depth, max_move_depth)
      setup(options)
    end

    def execute
      @move, @score = move_scores.send(max_or_min_by, &:last)
      self
    end

    private
    def setup(options) end

    def move_scores
      possible_moves.map { |move| [move, move_score(move)] }
    end

    def max_or_min_by
      @is_maximising ? :max_by : :min_by
    end

    def max_move_depth
      @initial_board.total_squares
    end

    def possible_moves
      @initial_board.empty_squares
    end

    def move_score(move)
      board_score(@initial_board.move(move))
    end

    def board_score(board)
      return final_score(board) if board.complete?
      return out_of_depth_score if out_of_depth?
      return recursive_score(board)
    end

    def final_score(board)
      board.winner? ? winning_score : drawing_score
    end

    def winning_score
      (base_winning_score * mini_max_multiplier) - depth_offset
    end

    def base_winning_score
      max_move_depth + 1
    end

    def mini_max_multiplier 
      @is_maximising ? 1 : -1
    end

    def depth_offset
      @is_maximising ? @depth : -@depth
    end

    def drawing_score
      DRAWING_SCORE
    end

    def out_of_depth?
      next_depth == @max_depth
    end

    def next_depth
      @depth + 1
    end

    def out_of_depth_score
      OUT_OF_DEPTH_SCORE
    end

    def recursive_score(board)
      self.class.new(board, recursive_options).execute.score
    end

    def recursive_options
      { depth: next_depth,
        is_maximising: !@is_maximising, 
        max_depth: @max_depth }.merge(additional_options)
    end

    def additional_options 
      {}
    end
  end
end
