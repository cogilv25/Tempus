require "world"
require "lib/xorshift"
require "vector"
RNGWorld = World:extend()

function RNGWorld:new(dimentions,seed)
	self.super:new(dimentions)

	self.rng = rng(seed)

	self:generateWorld()
end

function RNGWorld:generateWorld()
	for i=0, self.dim.x do
		for j=0, self.dim.y do
			self.grid[i][j] = self.rng:next()%5
		end
	end
end