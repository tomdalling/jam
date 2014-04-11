require 'gosu'
require 'active_support/all'
require 'jam/game'
require 'jam/vector'
require 'jam/sprite'
require 'jam/entity'
require 'jam/sprite_entity'
require 'jam/draw_context'
require 'jam/root_entity'
require 'jam/fps'
require 'jam/window'
require 'jam/asset_loader'
require 'jam/animation'
require 'jam/asset_collection'
require 'jam/camera'

module Jam

  def self.rand(range = 0.0..1.0)
    Random.rand(range.max - range.min) + range.min
  end

end
