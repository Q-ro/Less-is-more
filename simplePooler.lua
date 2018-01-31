--	#####################################################
--	# Title:		simplePooler.lua				    #
--	# Author:		Andres Mrad (Q-ro)			        #
--	# Date:			Jan 26 2018					        #
--	# Description:	A simple approach to object pooling	#
--	#####################################################

SimplePooler = {}
SimplePooler.__index = SimplePooler

local lg = love.graphics

function SimplePooler.create()
    local self = setmetatable({}, SimplePooler)

    self.pool = {}

    return self

end

function SimplePooler:draw()
    
    if #self.pool > 0 then
        for i = 1, #self.pool,1 do
            if self.pool[i]:IsActive() == true then
                return self.pool[i]:draw()
            end
        end    
    end

end

function SimplePooler:update(dt)
    
    if #self.pool > 0 then
        for i = 1, #self.pool,1 do
            if self.pool[i]:IsActive() == true then
                return self.pool[i]:update(dt)
            end
        end    
    end

end

function SimplePooler:createObject(posX,posY, duration)

    local pooledObject = self:getPooledObject()

    if pooledObject ~= nil then
        pooledObject:Init(posX,posY,duration)
        table.insert(self.pool,pooledObject)
    else
        pooledObject = PoppedBubble.create()
        pooledObject:Init(posX,posY,duration)
        table.insert(self.pool,pooledObject)
    end
end

function SimplePooler:getPooledObject()

    if #self.pool > 0 then
        for i = 1, #self.pool,1 do
            if self.pool[i]:IsActive() == false then
                return self.pool[i]
            end
        end
    end
    return nil
    
end