module Jam

  class SpriteEntity < Entity
    attr_accessor :visible
    attr_accessor :tint
    attr_accessor :rotation # degrees
    attr_reader :image
    jam_vector_accessor :position
    jam_vector_accessor :scale
    jam_vector_accessor :anchor

    def initialize
      super
      @visible = true
      @tint = 0xffffffff
      @rotation = 0
      @image = nil
      @position = Vector.new
      @scale = Vector.new(1,1)
      @anchor = Vector.new(0.5,0.5)
    end

    def update(secs_elapsed)
      if @image && @image.respond_to?(:update)
        @image.update(secs_elapsed)
      end
    end

    def draw
      return unless @image && @visible
      @image.draw_rot(
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
