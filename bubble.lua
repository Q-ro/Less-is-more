--	#################################################
--	# Title:		bubble.lua					    #
--	# Author:		Andres Mrad (Q-ro)			    #
--	# Date:			Dec 04 2017					    #
--	# Description:	Loads and sets the "enemies"	#
--	#################################################

Bubble = {}
Bubble.__index = Bubble

local lg = love.graphics

--- Constructor for te bubble "enemies"
function Bubble.create(posX,posY,moveSpeed, moveDir, bubbleIndex)
    --local self = Utils.ShallowCopy(Bubble)
    local self = setmetatable({}, Bubble)

    self.x = posX
    self.y = posY
    self.moveSpeed = moveSpeed
    self.moveDirection = moveDir

    self.bubbleIndex = bubbleIndex

    self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
    self.body:setBullet(true)
    self.shape = love.physics.newCircleShape(12)
    self.fix = love.physics.newFixture(self.body, self.shape, 0.1)
    self.fix:setUserData("bubble")




    self.Animation = {}
    self:loadAnimation("BubbleAnimation","Assets/Images/Bubble.png",64,64,0.9)
    self.currentAnimation = self.Animation["BubbleAnimation"]

    return self

end


function Bubble:hasFixture()

    if not self.fix:getUserData() then
        return false
    end

    return true

end

function Bubble:update(dt)

    if self:hasFixture() then

        self.currentAnimation.currentTime = self.currentAnimation.currentTime + dt
        if self.currentAnimation.currentTime >= self.currentAnimation.duration then
            self.currentAnimation.currentTime = self.currentAnimation.currentTime - self.currentAnimation.duration
        end
        self:move()
    
        --if self.body:getX() < - 35 or self.body:getX() > (love.graphics.getWidth() ) or 
        --self.body:getY() < -35 or self.body:getY()> (love.graphics.getHeight() ) or
        --not self.fix:getUserData() then
        --    self:destroy()
        --end

    end

end

function Bubble:draw()
    if self:hasFixture() then

        local spriteNum = math.floor(self.currentAnimation.currentTime / self.currentAnimation.duration * #self.currentAnimation.Quads) + 1
        lg.draw(self.currentAnimation.spriteSheet, self.currentAnimation.Quads[spriteNum],self.body:getX()-32, self.body:getY()-30, 0, 1)

        --lg.setColor(255, 0, 0)
        --lg.circle("line", self.body:getX(),self.body:getY(), self.shape:getRadius(), 20)
        --lg.setColor(255, 255, 255)
    end
end


function Bubble:loadAnimation(animationHolder,image, width, height, duration)
    self.Animation[animationHolder] = {}
    self.Animation[animationHolder].spriteSheet = lg.newImage(image);
    self.Animation[animationHolder].Quads = {};
 
    for y = 0, self.Animation[animationHolder].spriteSheet:getHeight() - height, height do
        for x = 0, self.Animation[animationHolder].spriteSheet:getWidth() - width, width do
            table.insert( self.Animation[animationHolder].Quads, lg.newQuad(x, y, width, height, self.Animation[animationHolder].spriteSheet:getDimensions()))
        end
    end
 
    self.Animation[animationHolder].duration = duration or 1
    self.Animation[animationHolder].currentTime = 0
end

function Bubble:move()

    if self:hasFixture() then

        local moveMagnitude = math.sqrt(math.exp(self.moveDirection[1],2) + math.exp(self.moveDirection[2],2))
        local moveMagnitudeNomalized =  {self.moveDirection[1] /moveMagnitude, self.moveDirection[2]/moveMagnitude}

        self.x = self.x + moveMagnitudeNomalized[1]*self.moveSpeed
        self.y = self.y + moveMagnitudeNomalized[2]*self.moveSpeed
        self.body:setPosition(self.x, self.y)
    end
    --self.body:applyForce( moveMagnitudeNomalized[1]*self.moveSpeed, moveMagnitudeNomalized[2]*self.moveSpeed)

end

function Bubble:destroy()
    -- Make object = nil will destroy object
    -- Using "for" loop with step = 1, because it's work faster then ipairs
    table.remove(bubbles, self.bubbleIndex)
    --self:setUserData(false)
    --self = nil
    --    --self = nil
    --for i = 1, #bubbles, 1 do
    --    if self == bubbles[i] then
    --        bubbles[i] = nil
    --    end
    --end

    --self.body.destroy( )
    --self.shape:destroy()
end