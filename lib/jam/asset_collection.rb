module Jam
  class AssetNotFoundError < StandardError; end
  class DuplicateAssetError < StandardError; end

  class AssetCollection
    attr_reader :window

    def initialize(window, manifest_path)
      raise(ArgumentError, "Can't read #{manifest_path}") unless File.readable?(manifest_path)
      @window = window
      @assets = {}

      @load_path = File.dirname(manifest_path)
      instance_eval(IO.read(manifest_path), manifest_path)
      @load_path = nil;
    end

    def [](key)
      @assets[key] || raise(AssetNotFoundError, key)
    end

    def resolve_path(path)
      fail unless @load_path
      File.join(@load_path, path)
    end

    private

      def asset(key, type, *args)
        raise(DuplicateAssetError, key) if @assets[key]
        @assets[key] = AssetLoader.load_asset(type, self, *args)
      end

  end

end
