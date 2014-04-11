module Jam
  module Sprite
    class Base
      def update(secs_elapsed)
      end

      def draw(context)
        raise NoMethodError
      end
    end
  end
end

