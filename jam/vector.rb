module Jam

  class Vector
    attr_accessor :x, :y

    def self.rand
      args = [1.0, -1.0]
      self.new(Jam.rand(*args), Jam.rand(*args))
    end

    def initialize(x = 0, y = 0)
      @x = x
      @y = y
    end

    def set!(other_or_x, y = nil)
      if y.nil?
        raise ArgumentError, other_or_x unless other_or_x.is_a? Vector
        @x = other_or_x.x
        @y = other_or_x.y
      else
        @x = other_or_x
        @y = y
      end

      self
    end

    def length
      if @x == 0 && @y == 0
        0
      else
        Math.sqrt(@x**2 + @y**2)
      end
    end

    def unitize
      dup.unitize!
    end

    def unitize!
      l = length
      byebug if l == 0
      @x /= l
      @y /= l
      self
    end

    def add!(other)
      raise ArgumentError, other unless other.is_a? Vector
      @x += other.x
      @y += other.y
      self
    end

    def +(other)
      dup.add!(other)
    end

    def subtract!(other)
      raise ArgumentError, other unless other.is_a? Vector
      @x -= other.x
      @y -= other.y
      self
    end

    def -(other)
      dup.subtract!(other)
    end

    def multiply!(scalar)
      @x *= scalar
      @y *= scalar
      self
    end

    def *(scalar)
      dup.multiply!(scalar)
    end

  end

end
