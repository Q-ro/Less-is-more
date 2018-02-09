--	#####################################
--	# Title:		util.lua			#
--	# Author:		Andres Mrad (Q-ro)	#
--	# Date:			Jan 29 2015			#
--	# Description:	Useful functions	#
--	#####################################

local lg = love.graphics

--- Warp around an interval of values
-- @param val: current value
-- @param min: minimum value of the interval
-- @param max: maximum value of the interval
-- @returns the warpped value
function wrap(val, min, max)
    if val < min then
        val = max
    end
    if val > max then
        val = min
    end
    return val
end

--- Clamps the value between 2 boundaries
-- @param val: current value
-- @param min: minimum value of the interval
-- @param max: maximum value of the interval
-- @returns the warpped value
function clamp(val, min, max)
    if min > max then
        min, max = max, min
    end
    return math.max(min, math.min(max, val))
end

function loadAnimation(image, width, height, duration)
    animation = {}
    animation.spriteSheet = lg.newImage(image)
    animation.Quads = {}

    for y = 0, animation.spriteSheet:getHeight() - height, height do
        for x = 0, animation.spriteSheet:getWidth() - width, width do
            table.insert(animation.Quads, lg.newQuad(x, y, width, height, animation.spriteSheet:getDimensions()))
        end
    end

    animation.duration = duration or 1
    animation.currentTime = 0

    return animation
end
