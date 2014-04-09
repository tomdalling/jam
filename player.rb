class Player < Jam::SpriteEntity

  def initialize
    super(:player)
    @tint = 0xff0000ff
    @scale.set!(2, 2)
  end

  def load(world)
    super
    @sprite.speed = 2
    @anchor.set!(@sprite.width/2, @sprite.height)
    @name = world.assets[:player_name]
  end

  def draw_self(context)
    super
    @name.draw(@anchor.x - @name.width/4,
               @anchor.y + 5,
               0, 0.5, 0.5, 0xffff0000)
  end

end
