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
	lg.printf("DESIGN, PROGRAMMING, \"SOUND\" & ART :", (screenWidth/2) - 305, 200,350,"center")
	lg.printf("ANDRES MRAD (Q-RO)", screenWidth/2, 225,250,"center")
	lg.printf("CREATED FOR LUDUM DARE 40 :", (screenWidth/2) - 270, 300,350,"center")
	lg.printf("THE MORE YOU HAVE THE HARDER IT GET", screenWidth/2, 325,250,"center")


	--lg.setFont(font.bold)

	--lg.printf("GAME OVER MAN, GAME OVER",(screenWidth/2 -100/2),20, 100,"center")

    --draw borko here
    --local doggoSpriteNum = math.floor(doggo.currentTime / doggo.duration * #doggo.Quads) + 1
	--lg.draw(doggo.spriteSheet, doggo.Quads[doggoSpriteNum], 250,(lg.getHeight()/2)-90, 0, 1)
    --local bubbleSpriteNum = math.floor(bubble.currentTime / bubble.duration * #bubble.Quads) + 1
	--lg.draw(bubble.spriteSheet, bubble.Quads[bubbleSpriteNum], lg.getHeight(),(lg.getHeight()/2)-80, 0, 1)
	--lg.draw(bubble.spriteSheet, bubble.Quads[bubbleSpriteNum], 60,(lg.getHeight()/2)+150, 0, 1)
	--lg.draw(instructionsImage, 191, 132, 0, 1, 1, 150, -50)
	
	


    --lg.setFont(font.digital)
	--lg.printf("Move Doggo",0,screenHeight -480, screenWidth -485,"center")
	--lg.printf("=",0,screenHeight/2 +175, 300,"center")
	--lg.printf("Collect Bubbles",0,screenHeight -480, screenWidth + 465,"center")
	--lg.printf("0 Speed = Game Over ",0,screenHeight - 120, screenWidth + 430,"center")


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
		
		---TODO: Add the sound effect
		--Play a sound effect
        playSound("confirm")
        setGameState("MAINMENU")

	-- on scape close the game
	elseif k == "action" then
		love.event.quit()
	end
end