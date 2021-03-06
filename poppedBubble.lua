--	#################################################################################################
--	# Title:		poppedBubble.lua                                                                #
--	# Author:		Andres Mrad (Q-ro)			                                                    #
--	# Date:			Jan 24 2018					                                                    #
--	# Description:	Loads and sets the text to be displayed after an enemy is  destroyed "bubbles"	#
--	#################################################################################################

PoppedBubble = {}
PoppedBubble.__index = PoppedBubble

local lg = love.graphics

--- Constructor for te bubble "enemies"
function PoppedBubble.create()
    local self = setmetatable({}, PoppedBubble)

    self.x = 0.0
    self.y = 0.0
    self.duration = 0.0
    self.isSlowDown = false
    self.currentAlpha = 0.0

    self.isActive = false
    self.fadeIn = true

    return self
end

function PoppedBubble:Init(posX, posY, isSlowDown, duration)
    self.x = posX
    self.y = posY
    self.duration = duration
    self.isSlowDown = isSlowDown
    self.currentAlpha = 0

    self.isActive = true
    self.fadeIn = true

    return self
end

function PoppedBubble:IsActive()
    return self.isActive
end

function PoppedBubble:draw()
    if self.isActive then
        lg.setFont(font.normal)
        lg.setColor(50, 150, 20, self.currentAlpha)
        lg.printf("SCORE UP", self.x, self.y, 120, "center")

        if self.isSlowDown then
            lg.setColor(140, 10, 30, self.currentAlpha)
            lg.printf("SPEED DOWN", self.x, self.y + 14, 120, "center")
        end

        lg.setColor(255, 255, 255, 255)
    end
end

function PoppedBubble:update(dt)
    if self.isActive then
        if self.fadeIn then
            self.currentAlpha = clamp(self.currentAlpha + 690 * dt, 0, 255)

            if self.currentAlpha >= 255 then
                self.fadeIn = false
            end
        else
            self.duration = self.duration - 1 * dt

            if self.duration <= 0 then
                self.currentAlpha = clamp(self.currentAlpha - 680 * dt, 0, 255)
            else
                self.isActive = false
            end
        end
    end
end
