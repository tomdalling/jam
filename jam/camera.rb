module Jam

  class Camera
    attr_reader :center # + custom writer
    attr_accessor :zoom

    def initialize
      @center = Vector.new
      @zoom = 1
    end

    def apply(window)
      window.translate(window.width/2.0, window.height/2.0) do
        window.scale(@zoom) do
          window.translate(-@center.x, -@center.y) do
            yield
          end
        end
      end
    end

    def center=(pos)
      @center.set!(pos)
    end

  end

end
