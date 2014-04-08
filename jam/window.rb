module Jam

  class Window < ::Gosu::Window
    attr_reader :world

    def initialize(options={})
      options = {
        width: 640,
        height: 480,
        fullscreen: false
      }.merge(options)

      super(options.fetch(:width), options.fetch(:height), options.fetch(:fullscreen))
      @lastUpdate = nil
      @world = make_world
      @fps = FPS.new
    end

    def update
      now = Gosu::milliseconds
      if @lastUpdate
        elapsed = now - @lastUpdate
        @fps.millis_elapsed(elapsed)
        @world.update(elapsed/1000.0)
      end
      @lastUpdate = now
    end

    def draw
      @world.draw
      @fps.frame_rendered
    end

    def fps
      @fps.value
    end

    protected

      def make_world
        World.new(AssetCollection.new(self, 'assets/manifest.rb'))
      end

  end

end
