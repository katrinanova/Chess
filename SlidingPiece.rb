require_relative 'piece.rb'

class SlidingPiece < Piece

  def moves
    valid_moves = []
    x, y = @position

    move_dirs.each do |dir|
      dx, dy = dir
      new_position = [x + dx, y + dy]
      until @board.occupied?(new_position) || @board.edge?(new_position)
        valid_moves << new_position
        new_position[0] += dx
        new_position[1] += dy
      end

      if @board.occupied?(new_position) && @board.enemy?(new_position, color)
        valid_moves << new_position
      end
    end

    valid_moves
  end

end
