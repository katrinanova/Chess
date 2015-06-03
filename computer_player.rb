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


  def get_best_move
    candidates = get_legal_moves
    attack_moves = get_attack_moves(candidates)
    if attack_moves.empty?
      best_move = recursive_move_search(candidates)
    else
      best_move = find_best_attack(attack_moves)
    end

    best_move
  end

  def get_legal_moves
    pieces = @board.get_color_pieces(@color)
    moves = []
    pieces.each do |piece|
      moves += piece.moves.map { |mov| [piece.position, mov] }
    end

    moves
  end

  def get_attack_moves(candidates)
    candidates.select do |move|
      @board.occupied?(move[1]) &&
      @board.enemy?(move[1], color)
    end
  end

  def find_best_attack(candidates)
    best_move = []
    best_value = 0

    candidates.each do |move|
      value = PIECE_VALUES[@board[*move[1]].class]
      if value >= best_value
        best_value = value
        best_move = move
      end
    end

    best_move
  end

  ##DANGEROUS METHODS BELOW

  def recursive_move_search(candidates)
    # future_move_values = Hash.new {|h,k| h[k] = 0 }
    candidates.each do |candidate|
      value = simulate_own_move(candidate)
      return candidate unless value.nil?
    end

    # best_value = future_move_values.values.max
    # future_move_values.invert[best_value]
  end

  def simulate_own_move(move)
    new_board = @board.deep_dup
    new_board.move!(*move)
    old_board = @board
    @board = new_board
    opponent_move = simulate_opponent_moves
    @board.move!(*opponent_move)
    best_move = get_best_move

    value = nil

    if @board.occupied?([*best_move[1]])
      @board = old_board
      return PIECE_VALUES[@board[*best_move[1]]]
    end

    @board = old_board

    nil
  end

  def simulate_opponent_moves
    switch_color
    move = get_best_move
    switch_color
    move
  end

  def switch_color
    color == :black ? :white : :black
  end

end
