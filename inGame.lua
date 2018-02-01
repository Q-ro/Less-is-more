--	#############################################
--	# Title:		inGame.lua  				#
--	# Author:		Andres Mrad (Q-ro)			#
--	# Date:			Dec 02 2017 				#
--	# Description:	The main game scene 		#
--	#############################################

local lg = love.graphics
local score = 0
local time = 0
finalScore = 0
finalTime = 0

local bubblesCounter = 0

local speedTimer = 0
local spawnTimer = 0
local spawntRate = 1

local screenWidth = lg.getWidth()
local screenHeight = lg.getHeight()

bubbles = {}
bubblesToDestroy = {}
inGame = {}

---- Region Love functions

--- Set the initial values for the menu screen
function inGame.enter()
	
	world = love.physics.newWorld(0, 0, true)
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	map = Map.create()
	player = Player.create(lg.getWidth()/2,lg.getHeight()/2,2.7)

	bubblePooler = BubblePooler.create()
	bubbleTextPooler = BubbleTextPooler.create()
 
end

function inGame.update(dt)

	if player:getSpeed() > 0.1 then

		time = time + dt
		world:update(dt)
		player:update(dt)

		spawnTimer = spawnTimer  + dt
		speedTimer = speedTimer  + dt

		if spawnTimer >= 2 then

			for i = 0, math.floor(spawntRate) -1, 1 do
				SpawnBubble()
			end

			if math.floor(time) > 10 then
				spawntRate = math.floor(time/15)+1
			end
			spawnTimer = 0
		end

		if speedTimer >= 3 then
			player:updateSpeed(0.1)
			speedTimer = 0
		end

		if #bubbles > 0 then
			for i = 0, #bubbles + 1, 1 do
				if bubbles[i] ~= nil then
					if bubbles[i]:hasFixture() then
						bubbles[i]:update(dt)
					else
						table.insert(bubblesToDestroy, i)
						--bubbles[i] = nil
					end

				end
			end
		end

		if #bubblesToDestroy > 0 then
			for i = 0, #bubblesToDestroy + 1, 1 do
				if bubblesToDestroy[i] ~= nil then
					bubblesToDestroy[i] = nil
				end
			end
		end
		
		bubbleTextPooler:update(dt)

	else
		finalScore = score
		finalTime = time
		setGameState("SCORESCREEN")
	end
	--bubbles[0]:update(dt)

end

function inGame.draw()
    
	lg.push()

	
	lg.setColor(255, 255, 255)
	
	map:draw(15,25)
	player:draw()

	if #bubbles > 0 then
		for i = 0,  #bubbles + 1, 1 do
			if bubbles[i] ~= nil then
				if bubbles[i]:hasFixture() then
					bubbles[i]:draw()
				end
			end
		end
	end

	bubbleTextPooler:draw()
	
	DrawScore()

		--lg.setColor(0, 0, 255)
		--love.graphics.print(text, 50, 50)
	lg.pop()
        
end


---- End Region


---- Region Input Functions

function inGame.keypressed(k, uni)

	--player:move(k)
    if k == "down" then
        
		---TODO: Add the sound effect
		--Play a sound effect
        --playSound("blip")
        
    elseif k == "up" then
        
		---TODO: Add the sound effect
		--Play a sound effect
        --playSound("blip")
        
	elseif k == "return" or k == " " then
		
		---TODO: Add the sound effect
		--Play a sound effect
	--	playSound("confirm")
	playSound("bork")

	-- on scape close the game
	elseif k == "escape" then
		love.event.quit()
	end
end

function inGame.action(k)
    if k == "down" then
        
		---TODO: Add the sound effect
		--Play a sound effect
        --playSound("blip")
        
    elseif k == "up" then
        
		---TODO: Add the sound effect
		--Play a sound effect
        --playSound("blip")
        
	elseif k == "jump" or k == "pause" then
		
		---TODO: Add the sound effect
		--Play a sound effect
		playSound("bork")

	-- on scape close the game
	elseif k == "action" then
		love.event.quit()
	end
end

---- End Region

function DrawScore()
	lg.setFont(font.digital)	
	lg.printf("SCORE : "..score .. "  SPEED :".. player:getSpeed() .." TIME : " .. math.floor(time),0,screenHeight - 40, screenWidth,"center")
end

function SpawnBubble()
	local spawnX = math.random(screenWidth-20)
	local spawnY = math.random(screenHeight-100)
	local spawnPos = math.random(4)
	local moveSpeed = math.random(2) + 1
	-- local dirX = math.random(10)
	-- local dirY = math.random(10)
	local dirX = 0
	local dirY = 0
	

	if spawnPos == 1 then
		spawnX = 0
		dirY = 0
		dirX = 1
	end
	if spawnPos == 2 then
		spawnY = 0
		dirY = 1
		dirX = 0
		
	end
	if spawnPos == 3 then
		spawnX = screenWidth - 20
		-- dirX = dirX * -1
		dirY = 0
		dirX = -1
	end
	if spawnPos == 4 then
		spawnY = screenHeight - 100
		-- dirY = dirY * -1
		dirY = -1
		dirX = 0
	end
	local bub = Bubble.create()
	table.insert(bubbles,bub:Init(spawnX,spawnY,moveSpeed, {dirX,dirY},bubblesCounter))
	
	--bubbles[bubblesCounter] = Bubble.create(spawnX,spawnY,moveSpeed, {dirX,dirY},bubblesCounter)
	bubblesCounter = #bubbles + 1
	--text = bubbles[bubblesCounter]

end

function SpawnText(x,y, duration)
	bubbleTextPooler:createObject(x,y,duration)
	--simplePooler:getPooledObject()
	--table.insert(poppedBubbles,PoppedBubble.create(x,y,duration))
	playSound("pop")
end

-------------------------------------------------------------------------------
-- Physics world callbacks
-------------------------------------------------------------------------------
function beginContact(a, b, coll)

	local playerFix, bubbleFix	
   
	-- Check what objects colliding
	if a:getUserData() == "player" then
		playerFix = a
	elseif b:getUserData() == "player" then
		playerFix = b
	end
   
	if a:getUserData() == "bubbleActive" then
		bubbleFix = a
	elseif b:getUserData() == "bubbleActive" then
		bubbleFix = b
	end
   
	-- If player collides with bullet
	if bubbleFix and playerFix then		

		SpawnText(bubbleFix:getBody():getX(),bubbleFix:getBody():getY(), 0.5)
		
		bubbleFix:setUserData("bubbleInactive")
		player:updateSpeed(-0.1)
		--SpawnText(bubbleFix:getBody():getX(), bubbleFix:getBody():getY())

		score = score + 1
	end
   end
   
   function endContact(a, b, coll)
	   --
   end
   
   function preSolve(a, b, coll)
	   --
   end
   
   function postSolve(a, b, coll, normalimpulse1, tangentimpulse1, normalimpulse2, tangentimpulse2)
	   --
   end
