require "gosu"
require_relative 'player'
require_relative 'zorder'

class GameWindow < Gosu::Window

	def initialize
		super 640, 480
		self.caption = "Gosu Tutorial Game"
		@stages = []
		@stages[0] = Gosu::Image.new("Images/Stage-1.png", :tileable => true)
		@stages[1] = Gosu::Image.new("Images/Stage-2.png", :tileable => true)
		@stages[2] = Gosu::Image.new("Images/Stage-3.png", :tileable => true)
		@background_image = @stages[rand(0..@stages.length - 1)]
		@player = Player.new
		@player.warp(width/2.0, height/2.0)
		@orbs = []
		@font = Gosu::Font.new(20)
		
	end

	def update
		@player.move_left if Gosu::button_down? Gosu::KbLeft
		@player.move_right if Gosu::button_down? Gosu::KbRight
		@player.move_up if Gosu::button_down? Gosu::KbUp
		@player.move_down if Gosu::button_down? Gosu::KbDown
		
		@player.move
		
	end

	def draw
		@player.draw
		@background_image.draw(0, 0, ZOrder::BACKGROUND)
		@font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
	end

	def button_down(id)
		close if id == Gosu::KbEscape
	end

end

window = GameWindow.new
window.show
