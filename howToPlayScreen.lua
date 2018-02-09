--	#############################################
--	# Title:		howToPlayScreen.lua 		#
--	# Author:		Andres Mrad (Q-ro)			#
--	# Date:			Jan 05 2018					#
--	# Description:	The score screen     		#
--	#############################################

howToPlayScreen = {}

local lg = love.graphics

local screenWidth = lg.getWidth()
local screenHeight = lg.getHeight()

function howToPlayScreen.enter()
	doggo = {}
	bubble = {}

	doggo = loadAnimation("Assets/Images/run_left.png", 96, 96, 1)
	bubble = loadAnimation("Assets/Images/Bubble.png", 64, 64, 1)

	instructionsImage = love.graphics.newImage("Assets/Images/HowToPlay.png")
end

function howToPlayScreen.update(dt)
	bubble.currentTime = bubble.currentTime + dt
	if bubble.currentTime >= bubble.duration then
		bubble.currentTime = bubble.currentTime - bubble.duration
	end

	doggo.currentTime = doggo.currentTime + dt
	if doggo.currentTime >= doggo.duration then
		doggo.currentTime = doggo.currentTime - doggo.duration
	end
end

function howToPlayScreen.draw()
	lg.push()

	lg.setFont(font.normal)
	lg.setColor(50, 150, 20, 255)
	lg.printf("SCORE UP", 160, 470, 120, "center")
	lg.setColor(140, 10, 30, 255)
	lg.printf("SPEED DOWN", 160, 470 + 14, 120, "center")
	lg.setColor(255, 255, 255, 255)

	--lg.setFont(font.bold)

	--lg.printf("GAME OVER MAN, GAME OVER",(screenWidth/2 -100/2),20, 100,"center")

	--draw borko here
	local doggoSpriteNum = math.floor(doggo.currentTime / doggo.duration * #doggo.Quads) + 1
	lg.draw(doggo.spriteSheet, doggo.Quads[doggoSpriteNum], 250, (lg.getHeight() / 2) - 90, 0, 1)

	local bubbleSpriteNum = math.floor(bubble.currentTime / bubble.duration * #bubble.Quads) + 1
	lg.draw(bubble.spriteSheet, bubble.Quads[bubbleSpriteNum], lg.getHeight(), (lg.getHeight() / 2) - 80, 0, 1)
	lg.draw(bubble.spriteSheet, bubble.Quads[bubbleSpriteNum], 60, (lg.getHeight() / 2) + 150, 0, 1)

	lg.draw(instructionsImage, 191, 132, 0, 1, 1, 150, -50)

	lg.setFont(font.digital)
	lg.printf("Move Doggo", 0, screenHeight - 480, screenWidth - 485, "center")
	lg.printf("=", 0, screenHeight / 2 + 175, 300, "center")
	lg.printf("Collect Bubbles", 0, screenHeight - 480, screenWidth + 465, "center")
	lg.printf("0 Speed = Game Over ", 0, screenHeight - 120, screenWidth + 430, "center")

	lg.pop()
end

function howToPlayScreen.keypressed(k, uni)
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
		setGameState("MAINMENU")
		playSound("bork")
	elseif k == "escape" then
		love.event.quit()
	end
end

function howToPlayScreen.action(k)
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
		playSound("confirm")
		setGameState("MAINMENU")
	elseif k == "action" then
		love.event.quit()
	end
end
