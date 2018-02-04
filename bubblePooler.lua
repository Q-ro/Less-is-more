--	#########################################################################################################
--	# Title:		bubblePooler.lua				                                                        #
--	# Author:		Andres Mrad (Q-ro)			                                                            #
--	# Date:			Jan 26 2018					                                                            #
--	# Description:	A simple approach to object pooling	(Used for the bubble objects displayed in the game) #
--	#########################################################################################################

BubblePooler = {}
BubblePooler.__index = BubblePooler

local lg = love.graphics

function BubblePooler.create()
    local self = setmetatable({}, BubblePooler)

    self.pool = {}

    return self

end

function BubblePooler:draw()
    
    if #self.pool > 0 then
        for i = 1, #self.pool,1 do
            if self.pool[i]:IsActive() == true then
               -- print("DRAW MOFO")
                self.pool[i]:draw()
            end
        end    
    end

end

function BubblePooler:update(dt)
    
    --print("About to update bubble")
    if #self.pool > 0 then
        for i = 1, #self.pool,1 do
            if self.pool[i]:IsActive() == true then
                --print("UPDATE MOFO !")
                self.pool[i]:update(dt)
            end
        end    
    end

end

function BubblePooler:createObject(posX,posY,moveSpeed,moveDir,bubbleIndex)

    local pooledObject = self:getPooledObject()

    if pooledObject ~= nil then
        pooledObject:Init(posX,posY,moveSpeed,moveDir,bubbleIndex)
        print("bubble pooled")
        table.insert(self.pool,pooledObject)
    else
        pooledObject = Bubble.create()
        print("bubble created")
        pooledObject:Init(posX,posY,moveSpeed,moveDir,bubbleIndex)
        table.insert(self.pool,pooledObject)
    end
end

function BubblePooler:getPooledObject()

    if #self.pool > 0 then
        for i = 1, #self.pool,1 do
            if self.pool[i]:IsActive() == false then
                return self.pool[i]
            end
        end
    end
    return nil
    
end