module Jam
  class Window < ::Gosu::Window
    attr_reader :game

    def initialize(options={})
      options = options.reverse_merge(
        game: nil, #required
        title: 'Game',
        size: [640, 480],
        fullscreen: false,
      )

      size = Vector.from(options.fetch(:size))
      super(size.x, size.y, options.fetch(:fullscreen))
      self.caption = options.fetch(:title)
      @game = options.fetch(:game)
      @draw_context = DrawContext.new(self)
      @lastUpdate = nil
      @fps = FPS.new
    end

    def update
      now = Gosu::milliseconds
      if @lastUpdate
        elapsed = now - @lastUpdate
        @fps.millis_elapsed(elapsed)
        @game.update(elapsed/1000.0)
      end
      @lastUpdate = now
    end

    def draw
      @game.draw(@draw_context)
      @fps.frame_rendered
    end

    def fps
      @fps.value
    end

    def button_down(*args)
      @game.button_down(*args)
    end

  end
end
