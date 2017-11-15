require "level"
require "xorshift"
require "vector"
RNGWorld = Level:extend()

function RNGWorld:new(dimentions,seed)
	self.rng = XOrShiftGenerator(seed)

	self.dim = dimentions or Vector(100,100)
	
	self.tileDim = Vector(30,30)

	self.grid = {}
	for i=0, self.dim.x do
		self.grid[i] = {}
	end
	self:generateWorld()
end

function RNGWorld:generateWorld()
	for i=0, self.dim.x do
		for j=0, self.dim.y do
			self.grid[i][j] = self.rng:next()%5
		end
	end
end

function RNGWorld:draw()
	love.graphics.setColor({185,0,255})
	for i=0, self.dim.x do
		for j=0, self.dim.y do
			if(self.grid[i][j] > 0) then
				if(self.grid[i][j] > 1) then
					if(self.grid[i][j] > 2) then
						if(self.grid[i][j] > 3) then
							love.graphics.setColor({185,0,255})
						else
							love.graphics.setColor({255,0,185})
						end
					else
					love.graphics.setColor({255,255,0})
					end
				else 
					love.graphics.setColor({0,255,0})
				end
    			love.graphics.rectangle("fill", i*30, j*30, self.tileDim.x, self.tileDim.y)
    		end
		end
	end
end