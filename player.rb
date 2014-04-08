class Player < Jam::SpriteEntity

  def initialize
    super(:player)
    @tint = 0xff0000ff
    @scale.set!(3, 3)
  end

  def load(world)
    super
    @sprite.speed = 2
  end

end
