require 'gosu'
require 'active_support/all'
require_relative 'jam/game'
require_relative 'jam/vector'
require_relative 'jam/sprite'
require_relative 'jam/entity'
require_relative 'jam/sprite_entity'
require_relative 'jam/draw_context'
require_relative 'jam/root_entity'
require_relative 'jam/fps'
require_relative 'jam/window'
require_relative 'jam/asset_loader'
require_relative 'jam/animation'
require_relative 'jam/asset_collection'
require_relative 'jam/camera'

module Jam

  def self.rand(range = 0.0..1.0)
    Random.rand(range.max - range.min) + range.min
  end

end
