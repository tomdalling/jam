module Jam

  class Entity
    attr_accessor :parent
    attr_reader :children

    def initialize()
      @children = []
      @parent
      @loaded = false
    end

    def update(secsElapsed)
      @children.each { |e| e.update(secsElapsed) }
      self
    end

    def draw
      @children.each { |e| e.draw }
      self
    end

    def addChildren(*entities)
      my_world = world
      @children.concat(entities)
      entities.each do |entity|
        entity.parent = self
        entity.send(:_load, my_world) if my_world
      end
      self
    end

    def deleteChildren(*entities)
      entities.each do |entity|
        entity.parent = nil
        @children.delete(entity)
      end
      self
    end

    def world
      @parent && @parent.world
    end

    protected

      def load(world)
      end

    private

      def _load(world)
        return if @loaded || world.nil?
        self.load(world)
        @loaded = true
        @children.each { |e| e.send(:_load, world) }
      end

  end

end
