class Ball < Jam::SpriteEntity

  def initialize(within_x, within_y)
    super()
    @velocity = Jam::Vector.rand.unitize * 100
    @rotational_velocity = Jam.rand(-360.0..360.0)
    @position.set!(Jam.rand(0..within_x), Jam.rand(0..within_y))
    self.scale = 0.3
  end

  def load(world)
    @image = world.assets[:player].instance
  end

  def update(secs_elapsed)
    @image.update(secs_elapsed)
    @position.add!(@velocity * secs_elapsed)
    @rotation += @rotational_velocity * secs_elapsed
  end

end
