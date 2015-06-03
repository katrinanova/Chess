class Knight < SteppingPiece
  def display
    color == :white ? "♘" : "♞"
  end

  def move_dirs
    [[2, 1], [-2, 1], [2, -1], [-2, -1],
     [1, 2], [-1, 2], [1, -2], [-1, -2]]
   end

end
