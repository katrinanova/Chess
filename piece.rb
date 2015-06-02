class Piece

  attr_reader :position, :color
  attr_accessor :board

  def initialize(start_pos, board, color)
    @position = start_pos
    @board = board
    @color = color
    @board[*start_pos] = self
  end

  def moves
    raise NotImplementedError
  end

  def move(pos)
    @board[*@position] = nil
    @position = pos
    @board[*pos] = self
  end

  def move_into_check(pos)
    new_board = @board.deep_dup
  end




end
