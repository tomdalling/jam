module Jam
  module Sprite
    class Image < Base
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
  end
end

class Gosu::Image
  def to_sprite
    Jam::Sprite::Image.new(self)
  end
end
