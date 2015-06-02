require_relative 'piece.rb'
require 'byebug'


class Pawn < Piece


  def moves
    valid_moves = []
    x, y = @position

    #debugger

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
      if @board.occupied?(new_position) && @board.enemy?(new_position, color)
        valid_moves << new_position
      end
    end

    valid_moves
  end

  
  def move_dirs
    valid_moves = []
    if color == :black
      valid_moves << [1, 0]
      if @position[0] == 1
        valid_moves << [2, 0]
      end
    else
      valid_moves << [-1, 0]
      if @position[0] == 6
        valid_moves << [-2, 0]
      end
    end

    valid_moves
  end

  def attack_dirs
    if color == :black
      [[1, 1], [1, -1]]
    else
      [[-1, -1], [-1, 1]]
    end
  end



end
