require "vector"
Zombie = Object:extend()

function Zombie:new()
    self.pos = Vector(500,500)
    self.width = 30
    self.height = 30
    self.vector = Vector()
    self.color = {255,0,0}
    self.speed = 130
end

function Zombie:update(dt)
	d = 99999999 --! distance
	cv = 0 --! closest player vector
    for i,v in ipairs(history.Entities) do
    	t = v:getPosition(frame)
    	if(t ~= false)then
    		td = (self.pos - v):getLength()
    		if(d > td)then
    			d = td
    			cv = v
    		end
    	end
    end
    self.vector = ((self.pos - cv):normalize()):scale(self.speed)
end

function Zombie:draw()
	love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.width, self.height)
end