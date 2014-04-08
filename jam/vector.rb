module Jam

  class Vector
    attr_accessor :x, :y

    def self.rand(x_range = nil, y_range = nil)
      x_range = -1.0..1.0 if x_range.nil?
      y_range = x_range if y_range.nil?
      self.new(Jam.rand(x_range), Jam.rand(y_range))
    end

    def self.from(obj)
      if obj.is_a?(Vector)
        obj
      else
        Vector.new(obj)
      end
    end

    def initialize(*args)
      args = [0, 0] if args.length == 0
      set!(*args)
    end

    def set!(x_or_obj, y = nil)
      if y
        @x = x_or_obj
        @y = y
      else
        case x_or_obj
        when Vector
          set!(x_or_obj.x, x_or_obj.y)
        when Numeric
          set!(x_or_obj, x_or_obj)
        when Array
          raise ArgumentError, x_or_obj unless x_or_obj.size == 2
          set!(x_or_obj[0], x_or_obj[1])
        else
          raise ArgumentError, x_or_obj
        end
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

    def length=(len)
      unitize!.multiply!(len)
    end

    def unitize
      dup.unitize!
    end

    def unitize!
      l = length
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

class Class

  def jam_vector_accessor(*names)
    jam_vector_writer(*names)
    attr_reader(*names)
  end

  def jam_vector_writer(*names)
    names.each do |attr|
      self.class_eval <<-end_class_eval
        def #{attr}=(*args)
          @#{attr}.set!(*args)
        end
      end_class_eval
    end
  end

end
