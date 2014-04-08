module Jam

  class Camera
    jam_vector_accessor :center
    attr_accessor :zoom

    def initialize
      @center = Vector.new
      @zoom = 1
    end

    def apply(window)
      window.translate(window.width/2.0, window.height/2.0) do
        window.scale(@zoom, @zoom) do
          window.translate(-@center.x, -@center.y) do
            yield
          end
        end
      end
    end

  end

end
