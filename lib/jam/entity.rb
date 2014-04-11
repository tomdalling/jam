module Jam
  class Entity < Sprite::Base
    attr_accessor :parent
    attr_reader :children

    def initialize
      @children = []
      @parent = nil
      @loaded = false
      @iterating = false
      @buffer = []
    end

    def update(secs_elapsed)
      each_child { |e| e.update(secs_elapsed) }
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
        self_game = game
        @children.concat(entities)
        entities.each do |entity|
          entity.parent = self
          entity.send(:_load, self_game) if self_game
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

    def game
      @parent && @parent.game
    end

    protected

      def load(game)
      end

    private

      def _load(game)
        return if @loaded || game.nil?
        self.load(game)
        @loaded = true
        @children.each { |e| e.send(:_load, game) }
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
