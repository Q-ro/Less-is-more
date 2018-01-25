--	#################################################################################################
--	# Title:		poppedBubble.lua                                                                #
--	# Author:		Andres Mrad (Q-ro)			                                                    #
--	# Date:			Jan 24 2017					                                                    #
--	# Description:	Loads and sets the text to be displayed after an enemy is  destroyed "bubbles"	#
--	#################################################################################################

PoppedBubble = {}
PoppedBubble.__index = Bubble

local lg = love.graphics

--- Constructor for te bubble "enemies"
function PoppedBubble.create(posX,posY,duration)

    local self = setmetatable({}, Bubble)

    self.x = posX
    self.y = posY
    self.duration = duration
    self.currentAlpha = 0

    return self

end

function PoppedBubble:draw()
    lg.push()
    lg.SetColor(50,150,20,self.currentAlpha)
    lg.printf("SCORE UP\nSPEED DOWN", self.x, self.y,50,"center")
    lg.pop()
end

function PoppedBubble:update(dt)
    self.currentAlpha = clamp(self.currentAlpha+1,0,255)
    
    if self.currentAlpha >= 255 then

        self.duration = duration - 1 * dt

        if self.duration <= 0 then
            self.currentAlpha = clamp(self.currentAlpha-1,0,255)
        end

    end
    
end