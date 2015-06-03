class Bishop < SlidingPiece
  def display
    color == :white ? "♗" : "♝"
  end

  def move_dirs
    [[1, 1], [-1, -1],
    [-1, 1], [1, -1]]
  end
end
