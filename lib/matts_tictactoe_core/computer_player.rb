require "matts_tictactoe_core/alpha_beta"

module MattsTictactoeCore
  class ComputerPlayer
    
    DefaultSleepTime = 0.5
    
    def initialize(options = {})
      @options = options
    end

    def type
      :computer
    end

    def get_move(board)
      sleep(@options.fetch(:sleep_time, DefaultSleepTime))
      AlphaBeta.new(board, @options).execute.move
    end
  end
end
