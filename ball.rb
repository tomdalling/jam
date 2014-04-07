class Ball < Jam::SpriteEntity

  def initialize(within_x, within_y)
    super()
    @velocity = Jam::Vector.rand.unitize * 100
    @rotational_velocity = Jam.rand(-360.0..360.0)
    @position.set!(Jam.rand(0..within_x), Jam.rand(0..within_y))
  end

  def load(world)
    @image = world.assets[:ball]
  end

  def update(secsElapsed)
    @position.add!(@velocity * secsElapsed)
    @rotation += @rotational_velocity * secsElapsed
  end

end
