require_relative 'Pawn.rb'
require_relative 'Knight.rb'
require_relative 'Bishop.rb'
require_relative 'King.rb'
require_relative 'Rook.rb'
require_relative 'Queen.rb'

class Board

  def initialize
    @board = Array.new(8) { Array.new(8) }

    setup_color(:black)
    setup_color(:white)

  end

  def setup_color(color)

    if color == :white
      x = 7
      px = 6
    else
      x = 0
      px = 1
    end

    Rook.new([x,0], self, color)
    Knight.new([x,1], self, color)
    Bishop.new([x,2], self, color)
    Queen.new([x,3], self, color)
    King.new([x,4],  self, color)
    Bishop.new([x,5], self, color)
    Knight.new([x,6], self, color)
    Rook.new([x,7], self, color)

    8.times do |i|
      Pawn.new([px, i], self, color)
    end

  end
  def [](x, y)
    @board[x][y]
  end

  def []=(x, y, piece)
    @board[x][y] = piece
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
      .position
  end

  def get_all_pieces(color)
    @board
      .flatten
      .select { |piece| piece.color == color }
  end

  def switch_color(color)
    return :white if color == :black
    return :black
  end


end
