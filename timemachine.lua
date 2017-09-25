TimeMachine = Object:extend()

function TimeMachine:new()
    self.pos = Vector(1,1)
    self.width = 30
    self.height = 30
    self.vector = Vector()
    self.color = {255,255,255}
end

function TimeMachine:update(dt)
	if((player.pos - self.pos):getLength() < 30)then
		player.pos.x = 45
		player.pos.y = 1
		history:addEntity(player.pos)
		enemy.pos.x = 500
		enemy.pos.y = 500
		frame = 0
	end
end

function TimeMachine:draw()
	love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.width, self.height)
end