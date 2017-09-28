require "core/lines"

class Board

  attr_reader :moves

  def initialize(moves = [])
    @moves = moves
    @lines = Lines.new(self)
  end

  def squares
    (1..total_squares)
  end

  def total_squares
    size ** 2
  end

  def size
    3
  end

  def move(square)
     valid_move?(square) ? Board.new(moves + [square]) : self
  end

  def valid_move?(square)
    square_in_bounds?(square) && square_empty?(square)
  end

  def complete?
    winner? || full?
  end

  def winner?
    winner != nil
  end

  def winner
    line_statuses.find { |status| status != :none }
  end

  def rows_as_square_numbers_and_statuses
    @lines.rows.map do |line| 
      line.map { |square_number| [square_number, square_status(square_number)] } 
    end
  end

  def next_player
    moves.length.even? ? :x : :o
  end

  def ==(other)
    other.class == self.class && other.moves == moves
  end

  def empty_squares
    squares.to_a - moves
  end

  private
  def square_in_bounds?(square)
    squares.include?(square)
  end

  def square_empty?(square)
    !moves.include?(square)
  end

  def line_statuses 
    lines_of_square_statuses.map do |line|
      next :x if line_of?(line, :x)
      next :o if line_of?(line, :o)
      :none
    end
  end

  def lines_of_square_statuses
    @lines.all.map { |line| line.map(&method(:square_status)) }
  end

  def square_status(square)
    square_mark(square) || :empty
  end

  def square_mark(square)
    if is_square_marked(square, :x)
      :x
    elsif is_square_marked(square, :o)
      :o
    end
  end

  def is_square_marked(square, mark)
    player_moves(mark).include?(square)
  end

  def player_moves(player_mark)
    move_selector = player_mark == :x ? :even? : :odd?
    select_moves { |i| i.send(move_selector) }
  end

  def select_moves(&index_selector)
    move_indexes = moves.each_index.select(&index_selector)
    moves.values_at(*move_indexes)
  end

  def line_of?(line, status)
    line.all? { |square_status| square_status == status }
  end

  def full?
    moves.length == total_squares
  end
end
