require "vector"
Entity = Object:extend()

function Entity:new()
	self.pos = Vector(0,0)
	self.dim = Vector(30,30)
	self.color = {0,0,0}
end

function Entity:update(dt)
	error("update function was not overridden in a derivative of Entity")
end

function Entity:draw()
	love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.dim.x, self.dim.y)
end