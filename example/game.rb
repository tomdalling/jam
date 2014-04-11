require 'jam'
require_relative 'ball'
require_relative 'player'

class Game < Jam::Game
  window title: 'Test Game', size: [640, 480]

  def initialize
    super
    @camera = Jam::Camera.new
    @player = Player.new

    @player.position.set!(@window.width/2, @window.height/2)
    @root.attach_children(@player)
    assets[:music].play(true)
  end

  def button_down(button_id)
    quit if button_id == Gosu::KbEscape

    @root.attach_children(Ball.new(1, @player.position))
    assets[:sound].play
  end

  def update(secs_elapsed)
    @camera.center = @player.position

    @player.position.x += 10 if window.button_down? Gosu::KbRight
    @player.position.x -= 10 if window.button_down? Gosu::KbLeft
    @player.position.y += 10 if window.button_down? Gosu::KbDown
    @player.position.y -= 10 if window.button_down? Gosu::KbUp
    super
  end

  def draw(context)
    assets[:background].draw(0,0,0)
    @camera.apply(context) { super }
    assets[:font].draw("FPS: #{window.fps}", 500, 0, 0)
  end

end

Game.new.run

