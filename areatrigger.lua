AreaTrigger = Object:extend()

-- Maybe AreaTrigger should be given a list of Entities to
-- react to. Also event shouldn't be passed to it, instead
-- derivatives should override the function with a basic 
-- event to notify if no event is set (a status message?)

function AreaTrigger:new(x,y,width,height,event)
	self.pos = Vector(x or 0, y or 0)
	self.dim = Vector(width or 30, height or 30)
	self.event = event
end

function AreaTrigger:update(dt)
	-- Check for ghost collisions
	ghostColided = false
	for i,v in ipairs(history.Entities) do
        t = v:getPosition(frame)
        if(t ~= false)then
            if(self.pos - t):getLength() < math.max(player.dim.x,self.dim.x)then
            	ghostColided = true
            end
        end
    end
    -- Check for player and enemy collisions
	if((player.pos - self.pos):getLength() < math.max(player.dim.x,self.dim.x) or
		(enemy.pos - self.pos):getLength() < math.max(enemy.dim.x,self.dim.x) or ghostColided == true)then
		self:event();
	end
end