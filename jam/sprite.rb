module Jam
  
  class Sprite
    def update(secs_elapsed)
    end

    def draw(context)
      raise NoMethodError
    end
  end

  class ImageSprite
    def initialize(gosu_image)
      @image = gosu_image
    end

    def draw(context)
      @image.draw(0, 0, 0, 1, 1, context.tint)
    end

    def width
      @image.width
    end

    def height
      @image.height
    end
  end

  class ::Gosu::Image
    def to_sprite
      ImageSprite.new(self)
    end
  end

end
