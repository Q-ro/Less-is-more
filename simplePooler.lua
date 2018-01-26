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