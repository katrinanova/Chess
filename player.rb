class Player
  def initialize(name)
    @name = name
  end

  def play_turn
    raise NotImplementedError
  end
end
