module Jam

  class Entity
    attr_accessor :parent
    attr_reader :children

    def initialize()
      @children = []
      @parent
      @loaded = false

      @iterating = false
      @buffer = []
    end

    def update(secsElapsed)
      each_child { |e| e.update(secsElapsed) }
      self
    end

    def draw(context)
      each_child { |e| e.draw(context) }
      self
    end

    def attach_children(*entities)
      if @iterating
        @buffer << [__method__, *entities]
      else
        my_world = world
        @children.concat(entities)
        entities.each do |entity|
          entity.parent = self
          entity.send(:_load, my_world) if my_world
        end
      end

      self
    end

    def detach_children(*entities)
      if @iterating
        @buffer << [__method__, *entities]
      else
        entities.each do |entity|
          entity.parent = nil
          @children.delete(entity)
        end
      end

      self
    end

    def detach
      @parent.detach_children(self) if @parent 
    end

    def each_child(&block)
      return if @children.size == 0
      @iterating = true
      @children.each(&block)
    ensure
      @iterating = false
      flush_buffer
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

      def flush_buffer
        fail if @iterating

        @buffer.each do |item|
          method, *args = item 
          send(method, *args)
        end

        @buffer.clear
      end

  end

end
