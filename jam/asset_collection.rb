module Jam

  class AssetCollection

    class AssetNotFoundError < StandardError; end
    class DuplicateKeyError < StandardError; end

    def initialize(window, manifest_path)
      @window = window
      @assets = {}

      @load_path = File.dirname(manifest_path)
      instance_eval(IO.read(manifest_path), manifest_path)
      @load_path = nil;
    end

    def [](key)
      @assets[key] || raise(AssetNotFoundError, key)
    end

    private

      def asset(key, type, *args)
        raise(DuplicateKeyError, key) if @assets[key]
        @assets[key] = self.send("_load_#{type}", *args)
      end

      def _load_image(path)
        Gosu::Image.new(@window, _resolve_path(path), false)
      end

      def _load_sound(path)
        Gosu::Sample.new(@window, _resolve_path(path))
      end

      def _load_music(path)
        Gosu::Song.new(@window, _resolve_path(path))
      end

      def _resolve_path(relative_path)
        return File.join(@load_path, relative_path)
      end

  end

end
