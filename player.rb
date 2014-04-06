class Player < Jam::SpriteEntity

  def load(world)
    @image = world.assets[:player]
    @tint = 0xff0000ff
    @scale.set!(3, 3)
  end

  def update(secsElapsed)
    @rotation += secsElapsed * 180.0
  end

end
