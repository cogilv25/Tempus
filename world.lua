require "lib/game/vector"
World = Object:extend()

function World:new(dimentions)
	self.dim = dimentions or Vector(100,100)
	-- no way for user to set tile dimensions
	self.tileDim = Vector(30,30)

	self.grid = {}
	for i=0, self.dim.x do
		self.grid[i] = {}
		for j=0, self.dim.y do
			self.grid[i][j] = 0
		end
	end
end

function World:draw()
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
    			love.graphics.rectangle("fill", i*30-30, j*30-30, self.tileDim.x, self.tileDim.y)
    		end
		end
	end
end