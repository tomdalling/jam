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
      @anchor = Vector.new
    end

    def load(world)
      if @sprite.is_a?(Symbol)
        asset = world.assets[@sprite]
        asset = asset.to_sprite if asset.respond_to?(:to_sprite)
        @sprite = asset
      end
    end

    def update(secs_elapsed)
      @sprite.update(secs_elapsed) if @sprite
    end

    def draw(context)
      context.with_transform(@position, @anchor, @rotation, @scale, @tint) do
        draw_self(context)
        super
      end
    end

    protected

      def draw_self(context)
        @sprite.draw(context) if @sprite && @visible
      end

  end
end
