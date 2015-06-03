class ComputerPlayer < Player

  PIECE_VALUES = {
    King => 100,
    Queen => 9,
    Rook => 5,
    Bishop => 3,
    Knight => 4,
    Pawn  => 1
  }

  def initialize(color, board)
    super("Deep Blue", color)
    @board = board
  end

  def play_turn
    get_best_move
  end

  def get_legal_moves
    debugger
    pieces = @board.get_color_pieces(@color)
    moves = []
    pieces.each do |piece|
      moves += piece.moves.map { |mov| [piece.position, mov] }
    end

    moves
  end

  def get_best_move
    candidates = get_legal_moves
    attack_moves = candidates.select do |move|
      @board.occupied?(move[1]) &&
      @board.enemy?(move[1], color)
    end
    return candidates.sample if attack_moves.empty?

    best_move = []
    best_value = 0

    debugger
    attack_moves.each do |move|
      value = PIECE_VALUES[@board[*move[1]].class]
      if value >= best_value
        best_value = value
        best_move = move
      end
    end

    best_move
  end

end
