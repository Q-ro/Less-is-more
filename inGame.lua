--	#############################################
--	# Title:		inGame.lua  				#
--	# Author:		Andres Mrad (Q-ro)			#
--	# Date:			Dec 02 2017 				#
--	# Description:	The main game scene 		#
--	#############################################

local lg = love.graphics
local score = 0
local time = 0
local availableBorks = 3
finalScore = 0
finalTime = 0

local bubblesCounter = 0

local speedTimer = 0
local spawnTimer = 0
local spawntRate = 1

local screenWidth = lg.getWidth()
local screenHeight = lg.getHeight()

inGame = {}

local map = {}
local player = {}
local bubblePooler = {}
local bubbleTextPooler = {}
local timeForRandom = false

---- Region Love functions

--- Set the initial values for the menu screen
function inGame.enter()
	score = 0
	time = 0
	availableBorks = 3
	finalScore = 0
	finalTime = 0

	bubblesCounter = 0

	speedTimer = 0
	spawnTimer = 0
	spawntRate = 1

	world = love.physics.newWorld(0, 0, true)
	world:setCallbacks(beginContact)

	map = Map.create()
	player = Player.create(lg.getWidth() / 2, lg.getHeight() / 2, 2.7)

	bubblePooler = BubblePooler.create()
	bubbleTextPooler = BubbleTextPooler.create()
end

function inGame.update(dt)
	if player:getSpeed() > 0.1 then
		time = time + dt
		world:update(dt)
		player:update(dt)

		spawnTimer = spawnTimer + dt
		speedTimer = speedTimer + dt

		if spawnTimer >= 2 then
			for i = 0, math.floor(spawntRate) - 1, 1 do
				SpawnBubble()
			end

			if math.floor(time) > 10 then
				spawntRate = math.floor(time / 15) + 1
			end
			spawnTimer = 0
		end

		if time > 45 and timeForRandom == false then
			timeForRandom = true
		end

		if speedTimer >= 3 then
			player:updateSpeed(0.1)
			speedTimer = 0
		end

		bubblePooler:update(dt)
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

	map:draw(15, 25)
	player:draw()
	bubbleTextPooler:draw()
	bubblePooler:draw()

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
		-- on scape close the game
		---TODO: Add the sound effect
		--Play a sound effect
		--	playSound("confirm")
		playSound("bork")

		if availableBorks > 0 then
			availableBorks = availableBorks - 1

			local forcedPopedBubles = bubblePooler:popAllBubbles()

			score = score + #forcedPopedBubles

			for i = 1, #forcedPopedBubles, 1 do
				local posX, posY = unpack(forcedPopedBubles[i])
				--SpawnText(forcedPopedBubles[i][1].X,forcedPopedBubles[i][2].Y,false, 0.5)
				SpawnText(posX, posY, false, 0.5)
			end
		end
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
		-- on scape close the game
		---TODO: Add the sound effect
		--Play a sound effect
		playSound("bork")
	elseif k == "action" then
		love.event.quit()
	end
end

---- End Region

function DrawScore()
	lg.setFont(font.digital)
	lg.printf(
		"SCORE : " ..
			score .. "  SPEED :" .. player:getSpeed() .. " TIME : " .. math.floor(time) .. " BORKS : " .. availableBorks,
		0,
		screenHeight - 40,
		screenWidth,
		"center"
	)
end

function SpawnBubble()
	local spawnX = math.random(screenWidth - 20)
	local spawnY = math.random(screenHeight - 100)
	local spawnPos = math.random(4)
	local moveSpeed = math.random(2) + 1
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

	if timeForRandom then
		local spawnDiagonal = math.random(0, 1)
		moveSpeed = math.random(6) + 1
		if spawnDiagonal == 1 then
			if dirX == 0 then
				dirX = dirY
			elseif dirY == 0 then
				dirY = dirX
			end
		end
	end

	bubblePooler:createObject(spawnX, spawnY, moveSpeed, {dirX, dirY})
end

function SpawnText(x, y, isSlowDown, duration)
	bubbleTextPooler:createObject(x, y, isSlowDown, duration)

	if isSlowDown then
		playSound("pop")
	end
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
		SpawnText(bubbleFix:getBody():getX(), bubbleFix:getBody():getY(), true, 0.5)

		bubbleFix:setUserData("bubblePopped")
		player:updateSpeed(-0.1)
		--SpawnText(bubbleFix:getBody():getX(), bubbleFix:getBody():getY())

		score = score + 1
	end
end
