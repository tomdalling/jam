module Jam
  class Game
    attr_reader :window, :assets

    def initialize
      @window = Window.new(self.window_options.merge(game: self))
      @root = RootEntity.new(self)

      if self.asset_manifest_path
        @assets = AssetCollection.new(@window, self.asset_manifest_path)
      end
    end

    def button_down(button_id)
    end

    def update(secs_elapsed)
      @root.update(secs_elapsed)
    end

    def draw(context)
      @root.draw(context)
    end

    def run
      @window.show
    end

    def quit
      @window.close
    end

    class_attribute :window_options
    self.window_options = {}
    def self.window(options)
      self.window_options = self.window_options.merge(options)
    end

    class_attribute :asset_manifest_path
    DEFAULT_ASSET_MANIFEST = 'assets/manifest.rb'
    self.asset_manifest_path = File.readable?(DEFAULT_ASSET_MANIFEST) ? DEFAULT_ASSET_MANIFEST : nil
    def self.asset_manifest(path)
      self.assets_manifest_path = path
    end

  end
end
