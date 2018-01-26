--	#############################################
--	# Title:		mainMenu.lua				#
--	# Author:		Andres Mrad (Q-ro)			#
--	# Date:			Dec 02 2017 				#
--	# Description:	Main menu of the game		#
--	#############################################

-- Just a way to not have to write this all the time
local lg = love.graphics

-- Main menu stings and the game states they represent
local MAIN_MENU = {
	{"START GAME", "INGAME"}, 
	{"EXIT GAME", "EXITGAME"}
}

--- Local Variables
local screenWidth = lg.getWidth()
local screenHeight = lg.getHeight()
local gameName = "RAIN RUNNER: THE ADVENTURES OF BORKO"
local titleRectangleWidth = 100
local menuVecticalOffset = 180

mainMenu = {}


---- Region Love functions

--- Set the initial values for the menu screen
function mainMenu.enter()
	frames = {}
	frames = loadAnimation("Assets/Images/idle.png",96,96,1)
	
	menuSelection = 1
end

function mainMenu.update(dt)
	-- TODO: make stuff animate here
	frames.currentTime = frames.currentTime + dt
    if frames.currentTime >= frames.duration then
        frames.currentTime = frames.currentTime - frames.duration
    end
end

function mainMenu.draw()
	lg.push()

	lg.setFont(font.normal)

	lg.printf(gameName,(screenWidth/2 -350/2),30, 350,"center")

	local spriteNum = math.floor(frames.currentTime / frames.duration * #frames.Quads) + 1
    lg.draw(frames.spriteSheet, frames.Quads[spriteNum], (lg.getWidth()/2)-46,(lg.getHeight()/2)-60, 0, 1)

	lg.setFont(font.bold)
	for i=1,(#MAIN_MENU) do
		if i == menuSelection then
			lg.printf(">", (screenWidth/2 -titleRectangleWidth/2), (screenHeight/2) + menuVecticalOffset +menuSelection*13,titleRectangleWidth,"left")
		end
		lg.printf(MAIN_MENU[i][1],(screenWidth/2 -titleRectangleWidth/2),(screenHeight/2) + menuVecticalOffset +i*13, titleRectangleWidth,"center")

	end


	lg.pop()
end

---- End Region


---- Region Input Functions

function mainMenu.keypressed(k, uni)
	if k == "s" then
		menuSelection = wrap(menuSelection + 1, 1,(#MAIN_MENU))
		---TODO: Add the sound effect
		--Play a sound effect
		--playSound("blip")
	elseif k == "w" then
		menuSelection = wrap(menuSelection - 1, 1,(#MAIN_MENU))
		---TODO: Add the sound effect
		--Play a sound effect
		--playSound("blip")
	elseif k == "return" or k == " " then

		setGameState(MAIN_MENU[menuSelection][2])
		
		---TODO: Add the sound effect
		--Play a sound effect
		playSound("bork")

	-- on scape close the game
	elseif k == "escape" then
		love.event.quit()
	end
end

function mainMenu.action(k)
	if k == "down" then
		menuSelection = wrap(menuSelection + 1, 1,(#MAIN_MENU))
		---TODO: Add the sound effect
		--Play a sound effect
		--playSound("blip")
	elseif k == "up" then
		menuSelection = wrap(menuSelection - 1, 1,(#MAIN_MENU))
		---TODO: Add the sound effect
		--Play a sound effect
		--playSound("blip")
	elseif k == "jump" or k == "pause" then

		setGameState(MAIN_MENU[menuSelection][2])
		
		---TODO: Add the sound effect
		--Play a sound effect
		playSound("confirm")

	-- on scape close the game
	elseif k == "action" then
		love.event.quit()
	end
end

---- End Region