require_relative 'piece.rb'

class SteppingPiece < Piece

  def moves
    valid_moves = []
    x, y = @position

    move_dirs.each do |dir|
      dx, dy = dir
      new_position = [x + dx, y + dy]

      unless @board.occupied?(new_position) || @board.edge?(new_position)
        valid_moves << new_position
      end

      if @board.enemy?(new_position, color)
        valid_moves << new_position
      end

    end

    valid_moves
  end

end
