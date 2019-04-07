-- Written by Calum Lindsay.

-- I wrote this to test out an idea
-- there's not a lot to it at the moment.
-- There possibly never will be as
-- I mostly got what I wanted from it
-- This was completely written without
-- any intention of anyone reading it or
-- even trying to comprehend it so it may
-- have strange quirks here and there and
-- certainly isn't completely thought
-- through.

-- Controls:
-- WASD to move
-- move around a bit then go to the
-- white square at the top left to
-- go back in time and you'll see
-- your previous self moving around

function love.load()
	--! Include Requirements
	--! Libraries
	Object = require "lib/classic/classic"
	tick = require "lib/tick/tick"
	rng = require "lib/xorshift"
	bit = require "bit"
	
	--! Base Classes
	require "event"
	require "areatrigger"
	require "entity"
	require "world"
	require "level"

	--! High Level Classes
	require "history"
	require "timemachine"
	require "rectangle"
	require "player"
	require "zombie"
	require "rngworld"

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
	level = Level()
	level:loadFromFile("Data/MockPrefab.lvl")
	-- This should be defined in lvl file
	activator = AreaTrigger(21*30,9*30,30,30,moveDoors)
	activator.color = {185,0,255}
	frame = 1
	paused = false
end

function moveDoors() 
	level.terrain.grid[13][12] = 0;
	level.terrain.grid[14][12] = 0;
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
	love.graphics.translate(playArea.x/2 - (player.pos.x + player.dim.x), playArea.y/2 - (player.pos.y + player.dim.y/2))
	level:draw()
	enemy:draw()
    player:draw()
    timem:draw()
    love.graphics.setColor(activator.color)
    love.graphics.rectangle("fill", activator.pos.x, activator.pos.y, activator.wh.x, activator.wh.y)
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
    activator:update()
	enemy:update(d)

	--Not exactly accurate I know
	if((player.pos - enemy.pos):getLength() < 30)then
		displayTimedStatus("You Have Failed", 5)
	end
end

function love.keypressed(key)
	if(key == 'r')then
		refresh()
	elseif(key == "escape")then
		love.event.quit()
	end
end