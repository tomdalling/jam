require_relative 'jam'
require_relative 'ball'
require_relative 'player'
require 'byebug'

class GameWindow < Jam::Window

  def initialize
    super(width: 800, height: 600)
    @background = world.assets[:background]
    @camera = Jam::Camera.new
    @player = Player.new
    @player.position.set!(width/2, height/2)

    world.root.addChildren(@player)
  end

  def button_down(button_id)
    close if button_id == Gosu::KbEscape
  end

  def update
    @camera.center = @player.position

    @world.root.deleteChildren(@player)
    10.times do
      world.root.addChildren(Ball.new(1, 1))
      if world.root.children.size > 5000
        world.root.deleteChildren(world.root.children.first)
      end
    end
    @world.root.addChildren(@player)

    puts "          #{world.root.children.size}" if world.root.children.size % 100 == 1 && world.root.children.size < 5000

    @player.position.x += 10 if button_down? Gosu::KbRight
    @player.position.x -= 10 if button_down? Gosu::KbLeft
    @player.position.y += 10 if button_down? Gosu::KbDown
    @player.position.y -= 10 if button_down? Gosu::KbUp
    super
  end

  def draw
    @camera.apply(self) do
      @background.draw(0,0,0)
      super
    end
  end

end

GameWindow.new.show
