--	####################################################################################################################
--	# Title:		bubbleTextPooler.lua				                                                                   #
--	# Author:		Andres Mrad (Q-ro)			                                                                       #
--	# Date:			Jan 26 2018					                                                                       #
--	# Description:	A simple approach to object pooling	(Used for the text objects displayed after a bubble is popped) #
--	####################################################################################################################

BubbleTextPooler = {}
BubbleTextPooler.__index = BubbleTextPooler

local lg = love.graphics

function BubbleTextPooler.create()
    local self = setmetatable({}, BubbleTextPooler)

    self.pool = {}

    return self
end

function BubbleTextPooler:draw()
    if #self.pool > 0 then
        for i = 1, #self.pool, 1 do
            if self.pool[i]:IsActive() == true then
                self.pool[i]:draw()
            end
        end
    end
end

function BubbleTextPooler:update(dt)
    if #self.pool > 0 then
        for i = 1, #self.pool, 1 do
            if self.pool[i]:IsActive() == true then
                self.pool[i]:update(dt)
            end
        end
    end
end

function BubbleTextPooler:createObject(posX, posY, isSlowDown, duration)
    local pooledObject = self:getPooledObject()

    if pooledObject ~= nil then
        pooledObject:Init(posX, posY, isSlowDown, duration)
    else
        pooledObject = PoppedBubble.create()
        pooledObject:Init(posX, posY, isSlowDown, duration)
        table.insert(self.pool, pooledObject)
    end
end

function BubbleTextPooler:getPooledObject()
    if #self.pool > 0 then
        for i = 1, #self.pool, 1 do
            if self.pool[i]:IsActive() == false then
                return self.pool[i]
            end
        end
    end
    return nil
end
