require 'gosu'
require_relative 'jam/entity'
require_relative 'jam/sprite_entity'
require_relative 'jam/world'
require_relative 'jam/fps'
require_relative 'jam/window'
require_relative 'jam/asset_collection'
require_relative 'jam/vector'
require_relative 'jam/camera'

module Jam

  def self.rand(max = nil, min = 0)
    if max.nil?
      Random.rand
    else
      Random.rand(max - min) + min
    end
  end

end
