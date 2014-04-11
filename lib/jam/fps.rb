module Jam
  class FPS
    attr_reader :value

    def initialize
      @value = 0
      @value_this_second = 0
      @millis = 0
      @update_block = nil
    end

    def frame_rendered
      @value_this_second += 1
    end

    def millis_elapsed(millis)
      @millis += millis
      while @millis > 1000
        @millis -= 1000
        @value = @value_this_second
        @value_this_second = 0
        @update_block.call if @update_block
      end
    end

    def on_update(&block)
      @update_block = block
    end

  end
end
