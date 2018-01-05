--	#####################################################
--	# Title:		Rain Runner: The borko adventure	#
--	# Author:		Andres Mrad (Q-ro)					#
--	# Date:			Dec 02 2015							#
--	# Description:	Ninjas rescue squad					#
--	#####################################################

--- "Imports"

--Game Resources
require("resources")

--Classes
require("map")
require("player")
require("bubble")

--Useful Libs
require("helpers")

--Game States
require("mainMenu")
require("inGame")
require("exitGame")
require("scoreScreen")
require("exitGame")

-- A reference to the game states
local gamestates = 
{
	["INGAME"]=inGame,
	["MAINMENU"]=mainMenu,
	["SCORESCREEN"]=scoreScreen,
	["EXITGAME"]=exitGame
}

local lg = love.graphics

---- Region Love functions

--- Main load function
function love.load()
	 
	loadResources()	
	setGameState("MAINMENU")
    
    
end

--- Main update function
function love.update(dt)
	---Run update function of the current game state
	gamestates[state].update(dt)
end


function love.draw()
	lg.push()
	gamestates[state].draw()
	lg.pop()
	
end

--- Main keyboard handdler
function love.keypressed(k, uni)
	--let the current game state handdle the keyboard
	gamestates[state].keypressed(k, uni)
end

--- Main text input handdler
function love.textinput(text)
	if gamestates[state].textinput then
		--let the current game state handdle the input
		gamestates[state].textinput(text)
	end
end


---- End region

function setGameState(newState,value)
	-- set the current game state
	state = newState
	gamestates[state].enter(value)
end