XOrShiftGenerator = Object:extend()

function XOrShiftGenerator:new(seed)
	--Use supplied seed or static 64 bit value
	self.seed = seed or 1976839131
	self.state = self.seed
end


-- This is the xorshift* implementation from Wiki:
-- https://en.wikipedia.org/wiki/Xorshift
function XOrShiftGenerator:next()
	local a = bit.lshift(self.state,13)
	local b = bit.rshift(self.state,17)
	local c = bit.lshift(self.state,5)
	self.state = bit.bxor(self.state,a)
	self.state = bit.bxor(self.state,b)
	self.state = bit.bxor(self.state,c)
	return self.state * 88608198
end
