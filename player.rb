require "gosu"
require_relative 'zorder'

class Player

	attr_reader :score

	TURN_INCREMENT = 3.0
	ACCELERATION = 0.3
	COLLISION_DISTANCE = 35.0

	def initialize
		@x = @y = @vel_x = @vel_y = @angle = 0.0
		@score = 0
		@image = Gosu::Image.new("Images/Pacman.png")
		@waka = Gosu::Sample.new(".wav")
		@over = Gosu::Sample.new(".wav")
	end

	def warp(x, y)
		@x, @y = x, y
	end

	def turn_left
		@angle -= TURN_INCREMENT
	end

	def turn_right
		@angle += TURN_INCREMENT
	end

	def accelerate
		@vel_x += Gosu::offset_x(@angle, ACCELERATION)
		@vel_y += Gosu::offset_y(@angle, ACCELERATION)
		
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
			@waka.play
			true
			else
			false
			end
		end
	end
		
	private
		
		def colliding?(orb)
		Gosu::distance(@x, @y, orb.x, orb.y) < COLLISION_DISTANCE