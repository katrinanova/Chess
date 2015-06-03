# encoding: utf-8

class IllegalMoveError < StandardError
end

class SelfCheckError < StandardError
end

class OpponentPieceError < StandardError
end

class Board

  PIECE_ORDER = [Rook, Knight, Bishop, Queen,
                 King, Bishop, Knight, Rook ]

  def deep_dup
    new_board = Board.new
    self.get_pieces.each {|piece| new_square = piece.dup(piece.class, new_board)}
    new_board
  end

  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def new_game_setup
    setup_color(:black)
    setup_color(:white)
    nil
  end

  def setup_color(color)
    setup_royalty(color)
    setup_pawns(color)
  end

  def setup_royalty(color)
    row = color == :white ? 7 : 0

    PIECE_ORDER.each_with_index do |piece, col|
      piece.new([row, col], self, color)
    end
  end

  def setup_pawns(color)
    row = color == :white ? 6 : 1

    8.times do |col|
      Pawn.new([row, col], self, color)
    end
  end



  def [](row, col)
    @board[row][col]
  end

  def []=(row, col, piece)
    @board[row][col] = piece
  end

  def in_check?(color)
    king_pos = find_king_pos(color)
    enemy_pieces = get_color_pieces(switch_color(color))
    all_enemy_moves = []

    enemy_pieces.each do |piece|
      all_enemy_moves += piece.moves
    end

    all_enemy_moves.include?(king_pos)
  end

  def find_king_pos(color)
    self
      .get_color_pieces(color)
      .select { |piece| piece.is_a?(King) }
      .first
      .position
  end

  def get_color_pieces(color)
    self
      .get_pieces
      .select { |piece| piece.color == color }
  end

  def get_pieces
    @board
      .flatten
      .compact
  end

  def switch_color(color)
    color == :black ? :white : :black
  end

  def move!(start, end_pos)
    debugger
    piece = self[*start]
    raise IllegalMoveError unless piece.moves.include?(end_pos)
    piece.move(end_pos)
  end

  def move(color, start, end_pos)
    raise IllegalMoveError unless self.occupied?(start)
    raise OpponentPieceError unless self[*start].color == color
    raise SelfCheckError if self[*start].move_into_check?(end_pos)
    move!(start, end_pos)
  end

  def display
    horizontal = "+-------------------------------+"
    puts horizontal

    @board.each_with_index do |row, row_idx|
      print "|"
      row.each_with_index do |square, col_idx|
        square.nil? ? print("   |") : print(" #{square.display} |")
      end
      puts "\n"
      puts horizontal
    end

    nil
  end

  def edge?(pos)
    !pos.all? { |coor| coor.between?(0, 7)}
  end

  def enemy?(pos, color)
    return false if self.edge?(pos)
    self[*pos].color != color
  end

  def occupied?(pos)
    return false if self.edge?(pos)
    !self[*pos].nil?
  end

  def checkmate?(color)
    pieces = self.get_color_pieces(color)

    pieces.each do |piece|
      piece.moves.each do |move|
        return false if !piece.move_into_check?(move)
      end
    end

    true
  end
end
