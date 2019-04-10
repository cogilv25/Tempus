require "entity"
Zombie = Entity:extend()

function Zombie:new()
    self.super.new(self)
    self.pos = Vector(500,500)
    self.vector = Vector()
    self.color = {255,0,0}
    self.speed = 130
end

function Zombie:update(dt)
    --Find closest player / "ghost" and move towards them
    d = (self.pos - player.pos):getLength()
    cv = player.pos
    for i,v in ipairs(history.Entities) do
        t = v:getPosition(frame)
        if(t ~= false)then
            td = (self.pos - t):getLength()
            if(d > td)then
                d = td
                cv = t
            end
        end
    end
    self.vector = cv - self.pos
    self.vector:normalize()
    self.vector:scale(self.speed * dt)

    self.pos = self.pos + self.vector
end