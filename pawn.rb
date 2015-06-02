require_relative 'piece.rb'

class Pawn < Piece


  def moves
    valid_moves = []
    x, y = @position

    move_dirs.each do |dir|
      dx, dy = dir
      new_position = [x + dx, y + dy]
      unless @board.occupied?(new_position) || @board.edge?(new_position)
        valid_moves << new_position
      end
    end

    attack_dirs.each do |dir|
      dx, dy = dir
      new_position = [x + dx, y + dy]
      if @board.enemy?(new_position)
        valid_moves << new_position
      end
    end

    valid_moves
  end

  def move_dirs
    valid_moves = []
    if color == :white
      valid_moves << [0, 1]
      if @position[0] == 6
        valid_moves << [0, 2]
      end
    else
      valid_moves << [0, -1]
      if @position[0] == 1
        valid_moves << [0, -2]
      end
    end
  end

  def attck_dirs
    if color == :white
      [[1, 1], [-1, 1]]
    else
      [[1, -1], [-1, -1]]
    end
  end



end
