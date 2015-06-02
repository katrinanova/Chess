class Piece
  def initialize(start_pos, board)
    @position = start_pos
    @board = board
  end

  def moves
    raise NotImplementedError
  end
end
