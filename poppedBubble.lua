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
function PoppedBubble.create(posX,posY)

    local self = setmetatable({}, Bubble)

    self.x = posX
    self.y = posY

    return self

end

function PoppedBubble:draw()
    lg.printf("SCORE UP\nSPEED DOWN")
end