class BadInputError < StandardError
end

class HumanPlayer < Player
  VALID_MOVE_REGEX = /[a-h][1-8], ?[a-h][1-8]/

  def play_turn
    puts "What is your move? (f2, f3)"
    move = gets.chomp

    raise BadInputError unless move =~ VALID_MOVE_REGEX
    parse(move)

    rescue BadInputError
      puts "Incorrect input format, please try again"
      retry
  end

  def parse(move)
    move = move.split(",").map { |s| s.strip }
    letters = %w(a b c d e f g h)

    move.map { |s| [8 - s[1].to_i, letters.find_index(s[0])] }
  end
end
