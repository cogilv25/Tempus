require "rngworld"
Level = Object:extend()

function Level:new()
	self.terrain = World()

	self.entities = {}

	self.triggers = {}

	self.timeline = {}
end

function Level:loadFromFile(filename)
	contents, size = love.filesystem.read(filename)
    local numberList = {}
--	Convert a string to a list of numbers
    contents:gsub('%-?%d+', function(n) t[#t+1] = tonumber(n) end)
    if(numberList[1] == 1)then
    	self.terrain = RNGWorld(Vector(numberList[2],numberList[3]),numberList[4]) 
    else
    	self.terrain = World(Vector(numberList[2],numberList[3]))
    	for i=1,self.terrain.dim.x do
    		for j=1,self.terrain.dim.y do
    			self.terrain.grid[i][j] = 1
    		end
    	end
    end
end