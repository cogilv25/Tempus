function love.load()
	--! Include Requirements
	--! Libraries
	Object = require "lib/classic"
	tick = require "lib/tick"

	--! Base Classes
	require "event"
	require "areatrigger"

	--! High Level Classes
	require "history"
	require "timemachine"
	require "rectangle"
	require "player"
	require "zombie"

	love.window.setTitle("Tick Tick...")
	--!love.window.setFullscreen(true)
	love.graphics.setBackgroundColor(0,0,0)

	playArea = Vector(love.graphics.getDimensions())

	player = Player()
	enemy = Zombie()
	timem = TimeMachine()
	history = History()
	history:addEntity()
	displayTimedStatus()
	frame = 1
	paused = false
end

function displayTimedStatus(message,time)
	displayStatus = true
	status = message or "Systems Nominal"
	tick.delay(function() displayStatus = false end, time or 1)
end

local function load(filename)
	local ok, chunk, result
	ok, chunk = pcall( love.filesystem.load, filename ) -- load the chunk safely
	if not ok then
	  displayTimedStatus('Error: ' .. tostring(chunk))
	else
	  ok, result = pcall(chunk) -- execute the chunk safely

	  if not ok then -- will be false if there is an error
		displayTimedStatus('Error: ' .. tostring(result))
	  else
		displayTimedStatus('Reload Successful')
	  end
	end
end

function refresh()
	load("main.lua")
end

function love.draw()
	enemy:draw()
    player:draw()
    timem:draw()
    history:draw(frame)
    love.graphics.setColor(0,255,0)
    if(displayStatus)then
    	love.graphics.print(status)
	end
end

function love.update(d)
	tick.update(d)
	if(paused)then return end
	frame = frame + 1
	history:addData(player.pos)
    player:update(d)
    timem:update()
	enemy:update(d)

	if((player.pos - enemy.pos):getLength() < 30)then
		displayTimedStatus("You Have Failed", 5)
	end

	if(player.pos.x + 30 > playArea.x)then
		player.pos.x = playArea.x - 30
	elseif(player.pos.x < 0) then
		player.pos.x = 0
	end

	if(player.pos.y + 30 > playArea.y)then
		player.pos.y = playArea.y - 30
	elseif(player.pos.y < 0) then
		player.pos.y = 0
	end
end

function love.keypressed(key)
	if(key == 'r')then
		refresh()
	elseif(key == "escape")then
		love.event.quit()
	end
end