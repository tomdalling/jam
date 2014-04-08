module Jam

  class World
    attr_accessor :assets
    attr_reader :root

    def initialize(assets)
      @root = RootEntity.new(self)
      @draw_context = DrawContext.new(assets.window)
      @assets = assets
    end

    def draw
      @root.draw(@draw_context)
    end

    def update(secs_elapsed)
      @root.update(secs_elapsed)
    end

    private

      class RootEntity < Entity
        attr_reader :world

        def initialize(world)
          super()
          @world = world
        end

      end

  end

end
