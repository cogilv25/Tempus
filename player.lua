require "vector"
require "history"

Player = Object:extend()

function Player:new()
    self.pos = Vector(80,50)
    self.width = 33
    self.height = 43
    self.color = {255,255,255}
    self.direction = Vector()
    self.speed = 200
    self.quad = love.graphics.newQuad(0,0,33,43,33,43)
end

function Player:update(dt)
	--!TODO: Use the position of the mouse in a small mouse sandbox area
	--! to decide direction to stop glitching and so the user doesn't have to
	--! continuosly move the mouse to stay in front of the character 
	self.direction = Vector(love.mouse.getPosition()) - self.pos
	self.direction:normalize()

	if(love.keyboard.isDown('w'))then
		self.pos.x = self.pos.x + (self.speed * self.direction.x * dt)
		self.pos.y = self.pos.y + (self.speed * self.direction.y * dt)
	elseif(love.keyboard.isDown('s'))then
		self.pos.x = self.pos.x - (self.speed * self.direction.x * dt)
		self.pos.y = self.pos.y - (self.speed * self.direction.y * dt)
	end
	if(love.keyboard.isDown('d'))then
		self.pos.x = self.pos.x - (self.speed * self.direction.y * dt)
		self.pos.y = self.pos.y + (self.speed * self.direction.x * dt)
	elseif(love.keyboard.isDown('a'))then
		self.pos.x = self.pos.x + (self.speed * self.direction.y * dt)
		self.pos.y = self.pos.y - (self.speed * self.direction.x * dt)
	end
end

function Player:draw()
	love.graphics.setColor(self.color)
    love.graphics.draw(playerTex, self.quad, self.pos.x - self.width/2, self.pos.y - self.height/2,-math.atan2(self.direction.x,self.direction.y)+1.57079632679489661,1,1,self.width/2,self.height/2)
end