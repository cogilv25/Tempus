AreaTrigger = Object:extend()

function AreaTrigger:new(x,y,width,height,event)
	--!Position Vector
	self.pos = Vector(x or 0, y or 0)
	--!Width, Height Vector
	self.wh = Vector(width or 30, height or 30)
	--!Event to call when player enters area
	self.event = event
end

function AreaTrigger:update(dt)

	ghostColided = false
	for i,v in ipairs(history.Entities) do
        t = v:getPosition(frame)
        if(t ~= false)then
            if(self.pos - t):getLength() < math.max(player.dim.x,self.wh.x)then
            	ghostColided = true
            end
        end
    end
	if((player.pos - self.pos):getLength() < math.max(player.dim.x,self.wh.x) or
		(enemy.pos - self.pos):getLength() < math.max(enemy.width,self.wh.x) or ghostColided == true)then
		self:event();
	end
end