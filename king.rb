require_relative 'stepping_piece.rb'

class King < SteppingPiece
  def move_dirs
    [[1, 1], [-1, -1], [-1, 1], [1, -1],
     [1, 0], [ 0,  1], [-1, 0], [0, -1]]
  end
end
