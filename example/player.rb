class Player < Jam::SpriteEntity
  asset :player

  def load(game)
    super
    @tint = 0xff0000ff
    self.scale = 2
    @sprite.speed = 2
    @anchor.set!(@sprite.width/2, @sprite.height)
    @name = game.assets[:player_name]
  end

  def draw_self(context)
    super
    @name.draw(@anchor.x - @name.width/4,
               @anchor.y + 5,
               0, 0.5, 0.5, 0xffff0000)
  end

end
