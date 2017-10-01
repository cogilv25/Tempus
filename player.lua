require "vector"
require "history"

Player = Object:extend()

function Player:new()
    self.pos = Vector(80,50)
    self.width = 33
    self.height = 43
    self.color = {255,255,255}
    self.quad = love.graphics.newQuad(0,0,33,43,33,43)
    self.direction = Vector()
    self.speed = 200
end

function Player:update(dt)
	self.direction = Vector(love.mouse.getPosition()) - self.pos
	self.direction:normalize()

	if(love.keyboard.isDown('w'))then
		self.pos.x = self.pos.x + (self.speed * self.direction.x * dt)
		self.pos.y = self.pos.y + (self.speed * self.direction.y * dt)
	elseif(love.keyboard.isDown('s'))then
		self.pos.x = self.pos.x - (self.speed * self.direction.x * dt)
		self.pos.y = self.pos.y - (self.speed * self.direction.y * dt)
	end
	--!TODO: a and d
end

function Player:draw()
	love.graphics.setColor(self.color)
    love.graphics.draw(playerTex, self.quad, self.pos.x - self.width/2, self.pos.y - self.height/2,-math.atan2(self.direction.x,self.direction.y)+1.5708,1,1,self.width/2,self.height/2)
end