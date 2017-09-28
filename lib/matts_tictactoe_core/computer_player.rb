require "core/alpha_beta"

module Core
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
