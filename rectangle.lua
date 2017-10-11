require "vector"


--! TODO: TOTAL REFACTOR - Do we need this what does it do

Rectangle = Object:extend()

function Rectangle:new()
    self.pos = Vector(500,500)
    self.width = 30
    self.height = 30
    self.vector = Vector()
    self.color = {255,0,0}
end

function Rectangle:update(dt)
    self.pos.x = self.pos.x + self.vector.x * dt
    self.pos.y = self.pos.y + self.vector.y * dt
end

function Rectangle:draw()
	love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.width, self.height)
end