class Piece

  attr_reader :position, :color

  def initialize(start_pos, board, color)
    @position = start_pos
    @board = board
    @color = color
    @board[*start_pos] = self
  end

  def moves
    raise NotImplementedError
  end
end
