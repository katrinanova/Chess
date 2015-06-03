require_relative 'board.rb'

class Game
  def initialize(white_player, black_player)
    @white_player = white_player
    @black_player = black_player
    @board = Board.new
  end

  def play
    @board.play

  end
end
