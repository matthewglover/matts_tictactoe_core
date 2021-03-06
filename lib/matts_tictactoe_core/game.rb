require "matts_tictactoe_core/board"
require "matts_tictactoe_core/human_player"
require "matts_tictactoe_core/computer_player"

module MattsTictactoeCore
  class Game
    
    attr_reader :board, :player_x_type, :player_o_type
    
    def initialize(options = {})
      @max_depth = options.fetch(:max_depth, 6)
      @board = build_board(options)
      @player_x_type = options[:player_x_type]
      @player_o_type = options[:player_o_type]
      @computer_player = options.fetch(:computer_player, build_computer_player)
      @human_player = options.fetch(:human_player, build_human_player)
    end

    def build_board(options)
      options.fetch(:board, build_new_board(options));
    end

    def build_new_board(options)
      Board.ofSize(options.fetch(:board_size, 3))
    end

    def next_player
      next_player_type == :computer ? computer_player : human_player
    end

    def next_player_type
      instance_variable_get("@player_#{board.next_player}_type")
    end

    def next_move(square)
      @board = board.move(square)
    end

    def complete?
      @board.complete?
    end

    private

    def computer_player
      @computer_player
    end

    def human_player
      @human_player
    end

    def build_computer_player
      ComputerPlayer.new(max_depth: @max_depth)
    end
    
    def build_human_player
      HumanPlayer.new
    end
  end
end
