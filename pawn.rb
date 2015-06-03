class Pawn < Piece

  def display
    color == :white ? "♙" : "♟"
  end

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
      valid_moves << [2, 0]  if starting_position?
    else
      valid_moves << [-1, 0]
      valid_moves << [-2, 0] if starting_position?
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

  def starting_position?
    color == :black ? (@position[0] == 1) : (@position[0] == 6)
  end
end
