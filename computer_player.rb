class ComputerPlayer < Player

  def initialize(color, board)
    super("Deep Blue", color)
    @board = board
  end

  def play_turn

    pieces = @board.get_color_pieces(@color)
    last_valid_move = []
    pieces.shuffle.each do |piece|
      moves = piece.moves
      next if moves.empty?
      moves.each do |move|
        if @board.occupied?(move) && @board.enemy?(move, @color)
          return [piece.position, move]
        else
          last_valid_move = [piece.position, move]
        end
      end
    end

    last_valid_move
  end

end
