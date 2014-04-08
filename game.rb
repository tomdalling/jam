require 'byebug'
require_relative 'jam'
require_relative 'ball'
require_relative 'player'

class GameWindow < Jam::Window

  def initialize
    super(width: 800, height: 600)
    @background = world.assets[:background]
    @camera = Jam::Camera.new
    @player = Player.new
    @player.position.set!(width/2, height/2)

    world.root.attach_children(@player)
    world.assets[:music].play
  end

  def button_down(button_id)
    close if button_id == Gosu::KbEscape

    @world.root.attach_children(Ball.new(1, @player.position))
    world.assets[:sound].play
  end

  def update
    @camera.center = @player.position

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

    world.assets[:font].draw("FPS: #{fps}", 0, 0, 0)
  end

end

GameWindow.new.show
