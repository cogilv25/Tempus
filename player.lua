require "vector"

Player = Object:extend()

function Player:new()
    self.pos = Vector(50,50)
    self.width = 30
    self.height = 30
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
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.width, self.height)
end