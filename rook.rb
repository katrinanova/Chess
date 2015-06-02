require_relative 'SlidingPiece.rb'

class Rook < SlidingPiece
  def move_dirs
    [[1, 0], [0, 1], [-1, 0], [0, -1]]
  end
end
