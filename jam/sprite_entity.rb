module Jam

  class SpriteEntity < Entity
    attr_accessor :image
    attr_accessor :tint
    attr_accessor :rotation # degrees
    attr_reader :position # + custom writer
    attr_reader :scale # + custom writer
    attr_reader :anchor # + custom writer

    def initialize
      super
      @image = nil
      @tint = 0xffffffff
      @rotation = 0
      @position = Vector.new
      @scale = Vector.new(1,1)
      @anchor = Vector.new(0.5,0.5)
    end

    def position=(*args)
      @position.set!(*args)
    end

    def anchor=(*args)
      @anchor.set!(*args)
    end

    def scale=(*args)
      @scale.set!(*args)
    end

    def draw
      return unless @image
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
