require "ghost"

History = Object:extend()

function History:new()
	self.nEntities = 0
	self.Entities = {}
end

function History:draw(frame)
	for i=1,self.nEntities-1 do
		self.Entities[i]:draw(frame)
	end
end

function History:addData(vector)
	self.Entities[self.nEntities]:addData(vector:getCopy())
end

function History:addEntity(vector)
	self.nEntities = self.nEntities + 1
	self.Entities[self.nEntities] = Ghost()
end

function History:clear()
	self.nEntities = 0
	self.Entities = {}
end