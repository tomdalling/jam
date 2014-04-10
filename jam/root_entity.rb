module Jam
  class RootEntity < Entity
    attr_reader :game

    def initialize(game)
      super()
      @game = game
    end
  end
end
