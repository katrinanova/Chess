require_relative 'manifest.rb'

class Game
  #for debug purposes
  attr_reader :board

  def initialize(white_player, black_player, board)
    @white_player = white_player
    @black_player = black_player
    @board = board
    @current_player = @white_player
  end

  def self.test_setup
    human = HumanPlayer.new("test", :white)
    board = Board.new
    comp  = ComputerPlayer.new(:black, board)
    Game.new(human, comp, board).play
  end

  def play
    @board.new_game_setup

    until game_over?
      @board.display

      begin
        next_move = @current_player.play_turn

        @board.move(@current_player.color, *next_move)
        toggle_player

      rescue SelfCheckError
        unless @current_player.is_a?(ComputerPlayer)
          puts "You can't make that move, it would put you in check, please retry"
        end
        retry

      rescue OpponentPieceError
        puts "It's not your piece, plese retry"
        retry

      rescue IllegalMoveError
        puts "That is an illegal move, please retry"
        retry

      end
    end

    @board.display
    toggle_player
    puts "#{@current_player.name} won!"

  end

  def game_over?
    return false unless @board.in_check?(@current_player.color)
    @board.checkmate?(@current_player.color)
  end

  def toggle_player
    if @current_player == @black_player
      @current_player = @white_player
    else
      @current_player = @black_player
    end

    nil
  end

end
