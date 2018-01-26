--	#####################################################
--	# Title:		simplePooler.lua				    #
--	# Author:		Andres Mrad (Q-ro)			        #
--	# Date:			Jan 26 2018					        #
--	# Description:	A simple approach to object pooling	#
--	#####################################################

SimplePooler = {}
SimplePooler.__index = SimplePooler

local lg = love.graphics

function SimplePooler.create(posX,posY,moveSpeed, moveDir, bubbleIndex)
    local self = setmetatable({}, SimplePooler)

    self.pool = {}

end

function SimplePooler:GetPooledObject()

    for i = 0, #self.pool,1 do
        if self.pool[i]:IsActive() == false then
            return self.pool[i]
        end
    end
    return nil
    
end