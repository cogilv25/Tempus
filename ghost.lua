Ghost = Object:extend()

--! REFACTOR - don't like the way this works ghosts shouldn't track
--! how long they live it should be done externally and they can be
--! skipped when they die

function Ghost:new()
	self.history = {}
	self.color = {145,205,255}
	self.ftl = 0  --! Frames To Live
end

function Ghost:addData(vector)
	self.ftl = self.ftl + 1
	self.history[self.ftl] = vector
end

function Ghost:draw(frame)
	if(self.ftl > frame)then 
		love.graphics.setColor(self.color)
		love.graphics.rectangle("fill",self.history[frame].x,self.history[frame].y,30,30)
	end
end

function Ghost:getPosition(frame)
	if(self.ftl > frame)then
		return self.history[frame]
	else
		return false
	end
end