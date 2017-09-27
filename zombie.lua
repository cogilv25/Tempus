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
	d = (self.pos - player.pos):getLength() --! distance
	cv = player.pos --! closest player vector
    for i,v in ipairs(history.Entities) do
    	t = v:getPosition(frame)
    	if(t ~= false)then
    		td = (self.pos - t):getLength()
    		if(d > td)then
    			d = td
    			cv = t
    		end
    	end
    end
    self.vector = cv - self.pos
    self.vector:normalize()
    self.vector:scale(self.speed * dt)

    self.pos = self.pos + self.vector
end

function Zombie:draw()
	love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.width, self.height)
end