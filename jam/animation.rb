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
      AnimationSprite.new(self)
    end

  end

  class AnimationSprite
    attr_accessor :speed

    def initialize(animation)
      @animation = animation
      @speed = 1
      @secs_this_frame = 0
      @frame = 0
    end

    def update(secs_elapsed)
      @secs_this_frame += @speed * secs_elapsed
      while @secs_this_frame > @animation.spf
        next_frame
        @secs_this_frame -= @animation.spf
      end
    end

    def frame
      @animation.frames[@frame]
    end

    def draw(context)
      frame.draw(0, 0, 0, 1, 1, context.tint)
    end

    def height
      frame.height
    end

    def width
      frame.width
    end

    private

      def next_frame
        @frame = (@frame + 1) % @animation.frames.size
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

