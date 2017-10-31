Event = Object:extend()

function Event:new(func)
	self.__call = func
end