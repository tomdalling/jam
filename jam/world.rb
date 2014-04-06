module Jam

  class World
    attr_accessor :assets
    attr_reader :root

    def initialize(assets)
      @root = RootEntity.new(self)
      @assets = assets
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
