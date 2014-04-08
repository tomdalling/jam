class Ball < Jam::SpriteEntity
  jam_vector_accessor :velocity

  def initialize(generation = 1, position = nil, direction = nil)
    super(:ball)
    @velocity = Jam::Vector.new
    @generation = generation
    @rotational_velocity = Jam.rand(-360.0..360.0)
    @life = 2 - @generation*0.3

    @scale.set!(4.0/@generation)
    @position.set!(position) if position
    @velocity.set!(direction).multiply!(200/@generation) if direction
  end

  def update(secs_elapsed)
    @position.add!(@velocity * secs_elapsed)
    @rotation += @rotational_velocity * secs_elapsed

    @life -= secs_elapsed
    if @life <= 0
      split
      detach
    end
  end

  def split
    return if @generation > 4

    up = Ball.new(@generation + 1, @position, [0,-1])
    right = Ball.new(@generation + 1, @position, [1,0])
    down = Ball.new(@generation + 1, @position, [0,1])
    left = Ball.new(@generation + 1, @position, [-1,0])
    @parent.attach_children(up, right, down, left)
    detach
  end

end
