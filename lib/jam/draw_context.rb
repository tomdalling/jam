module Jam
  class DrawContext
    attr_reader :window

    def initialize(window)
      @window = window
      @tint_stack = [0xffffffff]
    end
    
    def with_transform(translation, anchor, rotation, scale, tint)
      @tint_stack.push(tint) #TODO: multiply tints

      @window.translate(translation.x, translation.y) do
        @window.scale(scale.x, scale.y) do
          @window.rotate(rotation) do
            @window.translate(-anchor.x, -anchor.y) do
              yield
            end
          end
        end
      end

      @tint_stack.pop()
    end

    def tint
      @tint_stack.last
    end

  end
end
