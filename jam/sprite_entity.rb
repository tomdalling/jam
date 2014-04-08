module Jam

  class SpriteEntity < Entity
    attr_accessor :visible
    attr_accessor :tint
    attr_accessor :rotation # degrees
    attr_reader :image
    jam_vector_accessor :position
    jam_vector_accessor :scale
    jam_vector_accessor :anchor

    def initialize(sprite = nil)
      super()
      @visible = true
      @tint = 0xffffffff
      @rotation = 0
      @sprite = sprite
      @position = Vector.new
      @scale = Vector.new(1,1)
      @anchor = Vector.new(0.5,0.5)
    end

    def load(world)
      if @sprite.is_a?(Symbol)
        asset = world.assets[@sprite]
        asset = asset.to_sprite if asset.respond_to?(:to_sprite)
        @sprite = asset
      end
    end

    def update(secs_elapsed)
      if @sprite && @sprite.respond_to?(:update)
        @sprite.update(secs_elapsed)
      end
    end

    def draw
      return unless @sprite && @visible
      @sprite.draw_rot(
        @position.x,
        @position.y,
        0,
        @rotation,
        @anchor.x,
        @anchor.y,
        @scale.x,
        @scale.y,
        @tint
      )
    end

  end

end
