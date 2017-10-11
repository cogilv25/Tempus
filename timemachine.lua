TimeMachine = Object:extend()


--! TODO: TOTAL REFACTOR - How should this interact with the history mechanism
--! does it have any internal state or is it a glorified trigger point? if so
--! generalise it

function TimeMachine:new()
    self.pos = Vector(1,1)
    self.width = 30
    self.height = 30
    self.vector = Vector()
    self.color = {255,255,255}
end

function TimeMachine:update()
	--!TODO: not working, fix
	if((player.pos - self.pos):getLength() < 30)then
		player.pos.x = 80 + (history.nEntities * 60)
		player.pos.y = 50
		history:addEntity(player.pos)
		enemy.pos.x = 500
		enemy.pos.y = 500
		frame = 1
	end
end

function TimeMachine:draw()
	love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.width, self.height)
end