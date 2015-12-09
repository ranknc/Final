require "gosu"
require_relative 'zorder'



COLLISION_DISTANCE = 10.0

class Player

	attr_reader :score

	ACCELERATION = 0.05
	

	def initialize
		@x = @y = @vel_x = @vel_y = @angle = 0.0
		@score = 0
		@width = 640
		@height = 480
		@direction = 0
		@image = Gosu::Image.new("Images/Pacman.png")
		# @waka = Gosu::Sample.new(".wav")
		# @over = Gosu::Sample.new(".wav")
	end

	

	def warp(x, y)
		@x, @y = x, y
	end

	def move_left
		@angle = 180
		@vel_x -= 0.1
		@direction = 4
	end

	def move_right
		@angle = 0
		@vel_x += 0.1
		@direction = 3
	end

	def move_up
		@angle = 270
		@vel_y -= 0.1
		@direction = 1
	end

	def move_down
		@angle = 90
		@vel_y += 0.1
		@direction = 2
	end

	def move
		@x += @vel_x
		@y += @vel_y

		@x %= 640
		@y %= 480	

		@vel_x *= 0.95
		@vel_y *= 0.95
		if @x > @width - 10
			@vel_x = -1 * @vel_x
			@x = @width - 10
		end
		if @y > @height - 10
			@vel_y = -1 * @vel_y
			@y = @height - 10
		end
		if @x <= 5
			@vel_x = -1 * @vel_x
			@x = 5
		end		
		if @y <= 5
			@vel_y = -1 * @vel_y
			@y = 5
		end	
	end

	def draw
		@image.draw_rot(@x, @y, ZOrder::PLAYER, @angle)
	end

	def score
		@score
	end
	def collect_orbs(orbs)
		orbs.reject! do |orb|
			if colliding?(orb) then
			@score += 1
			@collected == 1
			# @waka.play
			true
			else
			false
			end
		end
	end
end
		
	private
		
		def colliding?(orb)
		Gosu::distance(@x, @y, orb.x, orb.y) < COLLISION_DISTANCE
		end