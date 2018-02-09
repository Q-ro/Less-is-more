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
    self.popAll = false

    return self
end

function BubblePooler:draw()
    if #self.pool > 0 then
        for i = 1, #self.pool, 1 do
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
        if not self.popAll then
            for i = 1, #self.pool, 1 do
                if self.pool[i]:IsActive() == true then
                    --print("UPDATE MOFO ! : " .. i)
                    self.pool[i]:update(dt)
                end
            end
        else
            for i = 1, #self.pool, 1 do
                if self.pool[i]:IsActive() == true then
                    --print("UPDATE MOFO ! : " .. i)
                    self.pool[i]:popBubble()
                end
            end
            self.popAll = false
        end
    end
end

function BubblePooler:popAllBubbles()
    local bubblePostions = {}

    for i = 1, #self.pool, 1 do
        if self.pool[i]:IsActive() == true then
            --print("UPDATE MOFO ! : " .. i)
            table.insert(bubblePostions, self.pool[i]:getCurrentPosition())
        --bubblePostions[i] = self.pool[i]:getCurrentPosition()
        end
    end

    self.popAll = true

    return bubblePostions
end

function BubblePooler:createObject(posX, posY, moveSpeed, moveDir)
    local pooledObject = self:getPooledObject()

    if pooledObject ~= nil then
        pooledObject:Init(posX, posY, moveSpeed, moveDir)
    else
        pooledObject = Bubble.create()
        --print("bubble created")
        pooledObject:Init(posX, posY, moveSpeed, moveDir)
        table.insert(self.pool, pooledObject)
    end
end

function BubblePooler:getPooledObject()
    if #self.pool > 0 then
        for i = 1, #self.pool, 1 do
            if self.pool[i]:IsActive() == false then
                return self.pool[i]
            end
        end
    end
    return nil
end
