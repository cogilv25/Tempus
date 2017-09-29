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

function History:rewind(entityID)
	--! TODO:
	--! If enemy positions were recorded I could keep entities[entityid]
	--! and rewind enemy position to before later generations altered it
	for i=entityID,self.nEntities do
		self.Entities[i] = nil
	end
	self.nEntities = entityID
	self.Entities[entityID] = Ghost()
	player.pos.x = 45 + ((entityID-1) * 35)
	player.pos.y = 1
	enemy.pos.x = 500
	enemy.pos.y = 500
	paused = true
	tick.delay(function() paused = false end, 3)
	frame = 1
end

function History:clear()
	self.nEntities = 0
	self.Entities = {}
	player.pos.x = 45
	player.pos.y = 1
	enemy.pos.x = 500
	enemy.pos.y = 500
end