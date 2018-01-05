--	#############################################
--	# Title:		scoreScreen.lua 			#
--	# Author:		Andres Mrad (Q-ro)			#
--	# Date:			Dec 29 2017 				#
--	# Description:	The score screen     		#
--	#############################################

scoreScreen = {}

local lg = love.graphics

local screenWidth = lg.getWidth()
local screenHeight = lg.getHeight()

function scoreScreen.enter()
    frames = {}
    frames = loadAnimation("Assets/Images/idle.png",96,96,1)
end


function scoreScreen.update(dt)
    frames.currentTime = frames.currentTime + dt
    if frames.currentTime >= frames.duration then
        frames.currentTime = frames.currentTime - frames.duration
    end
end

function scoreScreen.draw()
    lg.push()

	lg.setFont(font.bold)

	lg.printf("GAME OVER MAN, GAME OVER",(screenWidth/2 -100/2),20, 100,"center")

    --draw borko here
    local spriteNum = math.floor(frames.currentTime / frames.duration * #frames.Quads) + 1
    lg.draw(frames.spriteSheet, frames.Quads[spriteNum], (lg.getWidth()/2)-46,(lg.getHeight()/2)-60, 0, 1)


    lg.setFont(font.digital)
	lg.printf("Final Score : " .. finalScore .. " Final Time : "..finalTime,0,screenHeight - 90, screenWidth,"center")


	lg.pop()

end

function scoreScreen.keypressed(k, uni)

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
    setGameState("MAINMENU")
	playSound("bork")

	-- on scape close the game
	elseif k == "escape" then
		love.event.quit()
	end
end

function scoreScreen.action(k)
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
        playSound("confirm")
        setGameState("MAINMENU")

	-- on scape close the game
	elseif k == "action" then
		love.event.quit()
	end
end