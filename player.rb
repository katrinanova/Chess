class Player

  attr_reader :color, :name

  def initialize(name, color)
    @name = name
    @color = color
  end

  def play_turn
    raise NotImplementedError
  end
end
