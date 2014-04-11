module Jam

  class Camera
    jam_vector_accessor :center
    jam_vector_accessor :zoom

    def initialize
      @center = Vector.new
      @zoom = Vector.new(1, 1)
      @window_center = Vector.new
    end

    def apply(context)
      @window_center.set!(context.window.width/2.0, context.window.height/2.0)
      context.with_transform(@window_center, @center, 0, @zoom, 0xffffffff) do
        yield
      end
    end

  end

end
