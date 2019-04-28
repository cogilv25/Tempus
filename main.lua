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
-- through. <- I might have changed may
-- mind...

-- Controls:
-- WASD to move
-- move around a bit then go to the
-- white square at the top left to
-- go back in time and you'll see
-- your previous self moving around

-- TODO:
-- Tidy & comment
-- General refactor 
-- Activators should be a part of the lvl file format
-- Collision detection
-- Some levels with unique puzzles
-- Pause Menu
-- Tables update when reloading files (ex: snake update function can be edited)
-- Entire level reset with one call (level keeps track of everything)
-- Layers


-- Includes
bit = require "bit"
Object = require "lib/thirdparty/classic/classic"
tick = require "lib/thirdparty/tick/tick"
rng = require "lib/xorshift/xorshift"
binser = require "lib/thirdparty/binser"

requiredFiles = {"level","history","timemachine","player","zombie","rngworld"}
for i=1,#requiredFiles do
	require(requiredFiles[i])
end

function love.load()

	love.window.setTitle("Tempus (Working Title)")
	love.graphics.setBackgroundColor(0,0,0)

	playArea = Vector(love.graphics.getDimensions())

	player = Player()
	enemy = Zombie()
	timem = TimeMachine()
	history = History()
	history:addEntity()
	displayTimedStatus()
	level = Level()
	level:loadFromFile("Data/levels/MockPrefab.lolvl")
	frame = 1
	paused = false

	-- This should be defined in lvl file
	activator = AreaTrigger(21*30,9*30,30,30)
	activator.event = moveDoors
	activator.color = {185,0,255}
end

function moveDoors() 
	level.resetableTerrain.grid[13][12] = 0
	level.resetableTerrain.grid[14][12] = 0
end

-- If there is more than one message at a time we have an issue.
-- We need a queue of strings to display.
function displayTimedStatus(message,time)
	displayStatus = true
	status = message or "No Text Set For Timed Status"
	tick.delay(function() displayStatus = false end, time or 2)
end

local function load(filename)
	-- Load and execute the file checking for errors
	local ok, chunk, result
	ok, chunk = pcall( love.filesystem.load, filename )
	if not ok then
	  displayTimedStatus('Error: ' .. tostring(chunk), 15)
	else
	  ok, result = pcall(chunk) 

	  if not ok then 
		displayTimedStatus('Error: ' .. tostring(result), 15)
	  else
		displayTimedStatus(filename ..' loaded successfully')
	  end
	end
end

function reloadScript()
	for i=1,#requiredFiles do
		load(requiredFiles[i])
	end
	load("main.lua")
end

function love.draw()
	love.graphics.translate(playArea.x/2 - (player.pos.x + player.dim.x), playArea.y/2 - (player.pos.y + player.dim.y/2))
	level:draw()
	enemy:draw()
    player:draw()
    timem:draw()
    love.graphics.setColor(activator.color)
    love.graphics.rectangle("fill", activator.pos.x, activator.pos.y, activator.dim.x, activator.dim.y)
    history:draw(frame)
    love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill",player.pos.x - 370, player.pos.y-285,60,20)
    love.graphics.setColor(255,255,255)
	love.graphics.print("Fps: " .. love.timer.getFPS(),player.pos.x - 367,player.pos.y-282)
    if(displayStatus)then
    	-- Maybe move status to the bottom right and draw a black box
    	-- behind it so text is visible on bright backgrounds but I 
    	-- think the box would look weird in the middle of the screen
    	love.graphics.printf(status, player.pos.x -85,player.pos.y-20,200,"center")
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

	--Squares are not spheres but this is temporary
	if((player.pos - enemy.pos):getLength() < math.max(player.dim.x,enemy.dim.x))then
		displayTimedStatus("Thou Hast Failed", 5)
	end
end

function love.keypressed(key)
	if(key == 'r')then
		reloadScript()
	elseif(key == "escape")then
		love.event.quit()
	end
end