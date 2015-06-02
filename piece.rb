class Piece
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
