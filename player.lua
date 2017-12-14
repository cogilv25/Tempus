require "vector"
require "history"

Player = Entity:extend()

function Player:new()
    self.super.new(self)
    self.pos = Vector(70,40)
    self.color = {0,0,255}
end

function Player:update(dt)
	if(love.keyboard.isDown('w'))then
		self.pos.y = self.pos.y - 200 * dt
	end
	if(love.keyboard.isDown('a'))then
		self.pos.x = self.pos.x - 200 * dt
	end
	if(love.keyboard.isDown('s'))then
		self.pos.y = self.pos.y + 200 * dt
	end
	if(love.keyboard.isDown('d'))then
		self.pos.x = self.pos.x + 200 * dt
	end

end

function Player:draw()
	love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.dim.x, self.dim.y)
end