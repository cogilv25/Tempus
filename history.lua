History = Object:extend()

function History:new()
	self.nEntities = 0
	self.Entities = {}
end

function History:draw(frame)
	for i=1,self.nEntities-1 do
		print(frame .. " " .. i)
		if(frame<self.Entities[i][1]-1)then
			love.graphics.setColor(player.color)
			love.graphics.rectangle("fill",self.Entities[i][frame+1].x,self.Entities[i][frame+1].y,30,30)
			print("draw: " .. self.Entities[i][frame+1].x ..  ", " .. self.Entities[i][frame+1].y)
		end
	end
end

function History:addData(vector)
	self.Entities[self.nEntities][self.Entities[self.nEntities][1]] = Vector(vector.x,vector.y)
	self.Entities[self.nEntities][1] = self.Entities[self.nEntities][1] + 1
end

function History:addEntity(vector)
	self.nEntities = self.nEntities + 1
	self.Entities[self.nEntities] = {2,vector}
end

function History:getData(entityID)
	return self.Entities[entityID]
end

function History:clear()
	self.nEntities = 0
	self.Entities = {}
end