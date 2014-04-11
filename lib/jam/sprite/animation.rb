module Jam
  module Sprite
    class Animation
      attr_accessor :speed

      def initialize(animation)
        @animation = animation
        @speed = 1
        @secs_this_frame = 0
        @frame = 0
      end

      def update(secs_elapsed)
        @secs_this_frame += @speed * secs_elapsed
        while @secs_this_frame > @animation.spf
          next_frame
          @secs_this_frame -= @animation.spf
        end
      end

      def frame
        @animation.frames[@frame]
      end

      def draw(context)
        frame.draw(0, 0, 0, 1, 1, context.tint)
      end

      def height
        frame.height
      end

      def width
        frame.width
      end

      private

        def next_frame
          @frame = (@frame + 1) % @animation.frames.size
        end

    end
  end
end
