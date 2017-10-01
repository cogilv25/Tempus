require "vector"
Zombie = Object:extend()

function Zombie:new()
    self.pos = Vector(1000,800)
    self.width = 35
    self.height = 43
    self.vector = Vector()
    self.color = {255,255,255}
    self.speed = 130
    self.quad = love.graphics.newQuad(0,0,35,43,35,43)
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
    love.graphics.draw(zombieTex,self.quad, self.pos.x - self.width/2, self.pos.y - self.height/2,-math.atan2(self.vector.x,self.vector.y)+1.5708,1,1,self.width/2,self.height/2)
end