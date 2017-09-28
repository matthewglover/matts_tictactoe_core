require "core/mini_max"

class AlphaBeta < MiniMax

  MAX_VALUE = 10000
  MIN_VALUE = -10000

  def execute
    possible_moves.each do |move|
      score = move_score(move)
      update_result!(move, score) if better_score?(score)
      break if (@beta <= @alpha)
    end

    self
  end

  private
  def setup(options)
    @alpha = options.fetch(:alpha, MIN_VALUE)
    @beta = options.fetch(:beta, MAX_VALUE)
    self.score = initial_score
  end

  def initial_score
    is_maximising ? @alpha : @beta
  end

  def better_score?(score)
    is_maximising ? (score > @alpha) : (score < @beta)
  end

  def update_result!(move, score)
    update_alpha_beta!(score)
    self.move = move
    self.score = score
  end

  def update_alpha_beta!(score)
    if is_maximising
      @alpha = score
    else
      @beta = score
    end
  end

  def additional_options 
    {alpha: @alpha, beta: @beta}
  end
end
