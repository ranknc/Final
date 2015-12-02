require "gosu"
require_relative 'zorder'

class Player

	attr_reader :score

	ACCELERATION = 0.3
	COLLISION_DISTANCE = 35.0

	def initialize
		@x = @y = @vel_x = @vel_y = @angle = 0.0
		@score = 0
		@image = Gosu::Image.new("Images/Pacman.png")
		# @waka = Gosu::Sample.new(".wav")
		# @over = Gosu::Sample.new(".wav")
	end

	def warp(x, y)
		@x, @y = x, y
	end

	def move_left
		@angle = 180
		@vel_x -= 0.5
	end

	def move_right
		@angle = 0
		@vel_x += 0.5
	end

	def move_up
		@angle = 270
		@vel_y -= 0.5
	end

	def move_down
		@angle = 90
		@vel_y += 0.5
	end

	def move
		@x += @vel_x
		@y += @vel_y

		@x %= 640
		@y %= 480	

		@vel_x *= 0.95
		@vel_y *= 0.95
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