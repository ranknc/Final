require "gosu"
require_relative 'zorder'

class Orb
	attr_reader :x, :y

	def initialize(animation)
		@animation = animation
		@color = Gosu::Color.new(0xff_ffffff)

		@x = rand * 640
		@y = rand * 480
		@collected = 0
	end

	def draw
		img = @animation[Gosu::milliseconds / 100 % @animation.size]
		img.draw(
			@x - img.width / 2.0,
			@y - img.height / 2.0,
			ZOrder::ORBS,
			1, 1, @color, :add)
	end
		def collected?
			@collected
		end
end