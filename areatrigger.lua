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
	if((player.pos - self.pos):getLength() < math.max(player.width,self.wh.x))then
		self:event();
	end
end