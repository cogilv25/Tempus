require "areatrigger"
TimeMachine = AreaTrigger:extend()

function TimeMachine:new()
   	self.super.new(self,30,30,30,30,self.activationEvent)
   	self.color = {255,255,255}
end

-- Unneccessary function atm
--[[
function TimeMachine:update(dt)
	self.super.update(dt)
end
--]]

function TimeMachine:draw()
	love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.wh.x, self.wh.y)
end

function TimeMachine:activationEvent()
	if((player.pos - self.pos):getLength() < 30)then
		player.pos.x = 45
		player.pos.y = 1
		history:addEntity(player.pos)
		enemy.pos.x = 500
		enemy.pos.y = 500
		frame = 1
	end
end