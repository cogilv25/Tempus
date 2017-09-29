function love.load()
	--! Include Requirements
	Object = require "lib/classic"
	tick = require "lib/tick"
	require "history"
	require "timemachine"
	require "rectangle"
	require "player"
	require "zombie"

	love.window.setTitle("Tick Tick...")
	love.window.setFullscreen(true)
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
	alive = true
	zoom = 1
	zoomv = 0
end

function detectCollisions()
	--! TODO: Quad trees or eq 
	--! detect ghost collisions with...
	for i,v in ipairs(history.Entities) do
		t = v:getPosition(frame)
		if(t ~= false)then
			--! zombie
			if((t - enemy.pos):getLength() < 30) then
				alive = false
				paused = true
			elseif((t - player.pos):getLength() < 30) then
				history:rewind(i)
			end
			--! player

		end
	end
	--! detect player on zombie collisions
	if((player.pos - enemy.pos):getLength() < 30)then
		alive = false
		paused = true
	end

	--! detect player on screen edge collisions
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
    love.graphics.scale(zoom,zoom)
	enemy:draw()
    player:draw()
    timem:draw()
    history:draw(frame)
    love.graphics.setColor(0,255,0)
    if(displayStatus)then
    	love.graphics.print(status)
	end
	if (paused)then
		if(alive) then
			love.graphics.setColor(255,255,255)
			love.graphics.print("Game Paused",(playArea.x/2)-(playArea.x/5),(playArea.y/2)-(playArea.y/5),0,10,10,0,0,0,0,0)
		else
			love.graphics.setColor(255,0,0)
			love.graphics.print("Game Over!",(playArea.x/2)-(playArea.x/5),(playArea.y/2)-(playArea.y/5),0,10,10,0,0,0,0,0)
		end
	end
end

function love.update(d)
	tick.update(d)
	if(paused)then return end
	frame = frame + 1
    timem:update()
	history:addData(player.pos)
    player:update(d)
	enemy:update(d)

	detectCollisions()
end

function love.keypressed(key)
	if(key == 'r')then
		refresh()
	elseif(key == 'escape')then
		love.event.quit()
	elseif(key == 'p' and alive)then
		paused = not paused
	end
end
