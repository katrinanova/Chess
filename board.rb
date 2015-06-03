# encoding: utf-8

class IllegalMoveError < StandardError
end

class SelfCheckError < StandardError
end

class Board

  def deep_dup
    new_board = Board.new
    @board.flatten.each do |square|
      unless square.nil?
        new_square = square.dup
        new_square.position = square.position.dup
        new_square.board = new_board
        new_board[*new_square.position] = new_square
      end
    end

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

    if color == :white
      row = 7
      pawn_row = 6
    else
      row = 0
      pawn_row = 1
    end

    Rook.new([row, 0], self, color)
    Knight.new([row, 1], self, color)
    Bishop.new([row, 2], self, color)
    Queen.new([row, 3], self, color)
    King.new([row, 4],  self, color)
    Bishop.new([row, 5], self, color)
    Knight.new([row, 6], self, color)
    Rook.new([row, 7], self, color)

    8.times do |i|
      Pawn.new([pawn_row, i], self, color)
    end
  end

  def [](row, col)
    @board[row][col]
  end

  def []=(row, col, piece)
    @board[row][col] = piece
  end

  def in_check?(color)
    king_pos = find_king(color)
    enemy_pieces = get_all_pieces(switch_color(color))
    all_enemy_moves = []

    enemy_pieces.each do |piece|
      all_enemy_moves += piece.moves
    end

    all_enemy_moves.include?(king_pos)
  end

  def find_king(color)
    @board
      .flatten
      .select { |piece| piece.is_a?(King) && piece.color == color }
      .first
      .position
  end

  def get_all_pieces(color)
    @board
      .flatten
      .reject { |square| square.nil? }
      .select { |piece| piece.color == color }
  end

  def switch_color(color)
    color == :black ? :white : :black
  end

  def move!(start, end_pos)
    raise IllegalMoveError unless self.occupied?(start)
    piece = self[*start]
    raise IllegalMoveError unless piece.moves.include?(end_pos)
    piece.move(end_pos)
  end

  def move(start, end_pos)
    raise SelfCheckError if self[*start].move_into_check?(end_pos)
    move!(start, end_pos)
  end

  def display
    horizontal = "+-------------------------------+"
    puts horizontal

    @board.each_with_index do |row, row_idx|
      print "|"
      row.each_with_index do |square, col_idx|

        case square
        when Pawn
          if square.color == :black
            print " ♟ |"
          else
            print " ♙ |"
          end
        when Knight
          if square.color == :black
            print " ♞ |"
          else
            print " ♘ |"
          end
        when Bishop
          if square.color == :black
            print " ♝ |"
          else
            print " ♗ |"
          end
        when Rook
          if square.color == :black
            print " ♜ |"
          else
            print " ♖ |"
          end
        when Queen
          if square.color == :black
            print " ♛ |"
          else
            print " ♕ |"
          end
        when King
          if square.color == :black
            print " ♚ |"
          else
            print " ♔ |"
          end
        else
          print "   |"
        end
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
    pieces = self.get_all_pieces(color)

    pieces.each do |piece|
      piece.moves.each do |move|
        return false if !piece.move_into_check?(move)
      end
    end

    true
  end
end
