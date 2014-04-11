module Jam

  class UnhandledAssetTypeError < StandardError; end
  class DuplicateLoaderError < StandardError; end
  class AssetLoadingFailedError < StandardError; end

  class AssetLoader
    @loaders = {}

    def self.load_asset(type, *args)
      loader = @loaders[type] || raise(UnhandledAssetTypeError, type)
      asset = loader.call(*args)
      raise(AssetLoadingFailedError, [type, *args]) unless asset
      asset
    end

    def self.register(type, &block)
      raise(DuplicateLoaderError, type) if @loaders[type]
      @loaders[type] = block
    end

  end

  AssetLoader.register(:image) do |collection, path|
    Gosu::Image.new(collection.window, collection.resolve_path(path), false)
  end

  AssetLoader.register(:sound) do |collection, path|
    Gosu::Sample.new(collection.window, collection.resolve_path(path))
  end

  AssetLoader.register(:music) do |collection, path|
    Gosu::Song.new(collection.window, collection.resolve_path(path))
  end

  AssetLoader.register(:font) do |collection, path, options|
    options = options.reverse_merge(
      height: 20, #pixels
    )

    Gosu::Font.new(collection.window, collection.resolve_path(path), options.fetch(:height))
  end

  AssetLoader.register(:label) do |collection, text, font_key|
    font = collection[font_key]
    Gosu::Image.from_text(collection.window, text, font.name, font.height)
  end

end

