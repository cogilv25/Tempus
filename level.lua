require "rngworld"
Level = Object:extend()

function Level:new()
	self.terrain = World()

    -- No point in initialising resetableTerrain yet

	self.entities = {}

	self.triggers = {}

	self.timeline = {}
end

function Level:loadFromFile(filename)
	contents, size = love.filesystem.read(filename)
    local numberList = {}
--	Convert a string to a list of numbers
    contents:gsub('%-?%d+', function(n) numberList[#numberList+1] = tonumber(n) end)
    if(numberList[1] == 1)then
    --	Randomly generated level
    	self.terrain = RNGWorld(Vector(numberList[2],numberList[3]),numberList[4]) 
    else
    --	Prefab/non-rng level
    	self.terrain = World(Vector(numberList[2],numberList[3]))
    	for i=1,self.terrain.dim.x do
    		for j=1,self.terrain.dim.y do
    			self.terrain.grid[i][j] = numberList[(i-1) + ((j-1)*self.terrain.dim.x) + 4]
    		end
    	end
    end
    self:resetTerrain()
end

function Level:resetTerrain()
    self.resetableTerrain = {grid={}}
    setmetatable(self.resetableTerrain, {__index = self.terrain})
    for i=0, self.terrain.dim.x do
        self.resetableTerrain.grid[i] = {}
        setmetatable(self.resetableTerrain.grid[i], {__index = self.terrain.grid[i]})
    end
end

function Level:draw()
	self.resetableTerrain:draw()
end
