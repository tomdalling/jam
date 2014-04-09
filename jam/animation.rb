module Jam

  class Animation
    attr_reader :frames, :fps, :spf

    def initialize(frames, options = {})
      options = {
        fps: 4
      }.merge(options)

      @frames = frames
      @fps = options.fetch(:fps)
      @spf = 1.0/@fps
    end

    def to_sprite
      Sprite::Animation.new(self)
    end

  end


  AssetLoader.register(:animation) do |collection, path, options = {}|
    options = {
      grid: [1,1], # [columns, rows]
      # optional keys:
      # row: 1 # only take frames from a single row (top row = 1)
    }.merge(options)

    columns, rows = options.delete(:grid)

    frames = Gosu::Image.load_tiles(
      collection.window,
      collection.resolve_path(path),
      -columns,
      -rows,
      false
    )

    if options[:row]
      r = options[:row] - 1
      raise ArgumentError if r >= rows
      first_frame = columns * r
      last_frame = first_frame + columns - 1
      frames = frames[first_frame..last_frame]
    end

    Animation.new(frames, options)
  end

end

