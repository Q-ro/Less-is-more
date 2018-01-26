--	#################################################################################################
--	# Title:		poppedBubble.lua                                                                #
--	# Author:		Andres Mrad (Q-ro)			                                                    #
--	# Date:			Jan 24 2017					                                                    #
--	# Description:	Loads and sets the text to be displayed after an enemy is  destroyed "bubbles"	#
--	#################################################################################################

PoppedBubble = {}
PoppedBubble.__index = PoppedBubble

local lg = love.graphics

--- Constructor for te bubble "enemies"
function PoppedBubble.create(posX,posY,duration)

    local self = setmetatable({}, PoppedBubble)

    self.x = posX
    self.y = posY
    self.duration = duration
    self.currentAlpha = 0

    self.isActive = true;
    self.fadeIn = true

    return self

end

function PoppedBubble:IsActive()
    return self.isActive
end

function PoppedBubble:draw()
    if self.isActive then
        lg.setFont(font.normal)
        lg.setColor(50,150,20,self.currentAlpha)
        lg.printf("SCORE UP", self.x, self.y,120,"center")
        lg.setColor(140,10,30,self.currentAlpha)
        lg.printf("SPEED DOWN", self.x, self.y+14,120,"center")
        lg.setColor(255,255,255,255)
    end

end

function PoppedBubble:update(dt)

    if self.isActive then    
        if self.fadeIn then
    
            self.currentAlpha = clamp(self.currentAlpha+790*dt,0,255)
    
            if self.currentAlpha >= 255 then
    
                self.fadeIn = false
                
            end
        else
            
            self.duration = self.duration - 1 * dt
    
            if self.duration <= 0 then
                self.currentAlpha = clamp(self.currentAlpha-680 * dt,0,255)
            else
                self.isActive = false;
            end
    
    
        end
    end

    
    
end