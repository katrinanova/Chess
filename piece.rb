class Piece
  def initialize(start_pos, board, color)
    @position = start_pos
    @board = board
    @color = color
  end

  def moves
    raise NotImplementedError
  end
end
