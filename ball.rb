class Ball < Jam::SpriteEntity

  def initialize(within_x, within_y)
    super()
    @velocity = Jam::Vector.rand.unitize * 100
    @position.x = Jam.rand(within_x)
    @position.y = Jam.rand(within_y)
  end

  def load(world)
    @image = world.assets[:ball]
  end

  def update(secsElapsed)
    @position.add!(@velocity * secsElapsed)
  end

end
