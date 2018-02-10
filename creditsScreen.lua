--	#############################################
--	# Title:		howToPlayScreen.lua 		#
--	# Author:		Andres Mrad (Q-ro)			#
--	# Date:			Jan 05 2018					#
--	# Description:	The score screen     		#
--	#############################################

creditsScreen = {}

local lg = love.graphics

local screenWidth = lg.getWidth()
local screenHeight = lg.getHeight()

function creditsScreen.enter()
end

function creditsScreen.update(dt)
end

function creditsScreen.draw()
	lg.push()

	lg.setFont(font.normal)
	lg.printf('DESIGN, PROGRAMMING, "SOUND" & ART :', (screenWidth / 2) - 305, 200, 350, "center")
	lg.printf("ANDRES MRAD (Q-RO)", screenWidth / 2, 225, 250, "center")
	lg.printf("CONCEPT FOR LUDUM DARE 40 :", (screenWidth / 2) - 270, 300, 350, "center")
	lg.printf("THE MORE YOU HAVE THE HARDER IT GET", screenWidth / 2, 325, 250, "center")

	lg.setColor(0, 220, 255)
	lg.printf("Check my Stuff at : brainfreezestudios.com", 200, screenHeight / 2 +200, 400, "center")
	lg.setColor(255, 255, 255)

	lg.pop()
end

function creditsScreen.keypressed(k, uni)
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

function creditsScreen.action(k)
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
