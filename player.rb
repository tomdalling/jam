class Player < Jam::SpriteEntity

  def load(world)
    @image = world.assets[:player].instance
    @image.speed = 2
    @tint = 0xff0000ff
    @scale.set!(3, 3)
  end

end
