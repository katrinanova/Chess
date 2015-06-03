class Queen < SlidingPiece
  def display
    color == :white ? "♕" : "♛"
  end

  def move_dirs
    [[1,  1], [-1, -1], [-1, 1], [1, -1],
     [1,  0], [ 0,  1], [-1, 0], [0, -1]]
  end
end
