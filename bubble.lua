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
function Bubble.create()
    
    local self = setmetatable({}, Bubble)

    return self

end

function Bubble:Init(posX,posY,moveSpeed, moveDir)

    self.x = posX
    self.y = posY
    self.moveSpeed = moveSpeed
    self.moveDirection = moveDir
    self.isActive = true
    self.isPopped = false

    self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
    self.body:setBullet(true)
    self.shape = love.physics.newCircleShape(12)
    self.fix = love.physics.newFixture(self.body, self.shape, 0.1)
    self.fix:setUserData("bubbleActive")

    self.Animation = {}
    self:loadAnimation("BubbleAnimation","Assets/Images/Bubble.png",64,64,0.9)
    self:loadAnimation("BubblePoppedAnimation","Assets/Images/BubblePopped.png",64,64,0.5)
    self.currentAnimation = self.Animation["BubbleAnimation"]

    return self
end

function Bubble:IsActive()
    return self.isActive
end

function Bubble:update(dt)

    if self.isActive == true then

        self.currentAnimation.currentTime = self.currentAnimation.currentTime + dt
        
        if self.currentAnimation.currentTime >= self.currentAnimation.duration then

            if self.isPopped == false then
                self.currentAnimation.currentTime = self.currentAnimation.currentTime - self.currentAnimation.duration
            else
                --print("bubble inactive")

                self.isActive = false
                self.fix = nil
                return
            end
            
        end

        
        if self.isPopped == false then
            self:move()
        end
            
            if self.fix:getUserData() == "bubblePopped" and self.isPopped == false then
                self.isPopped = true
                self.currentAnimation = self.Animation["BubblePoppedAnimation"]
            end


    end

end

function Bubble:draw()

    if self.isActive == true then

        local spriteNum = math.floor(self.currentAnimation.currentTime / self.currentAnimation.duration * #self.currentAnimation.Quads) + 1
        lg.draw(self.currentAnimation.spriteSheet, self.currentAnimation.Quads[spriteNum],self.body:getX()-32, self.body:getY()-30, 0, 1)

    end
end


function Bubble:loadAnimation(animationHolder,image, width, height, duration)
    self.Animation[animationHolder] = {}
    self.Animation[animationHolder] = loadAnimation(image, width, height, duration)
end

function Bubble:move()

    if self.isActive == true then

        --print("move speed : "..self.moveSpeed)
        local moveMagnitude = math.sqrt(math.exp(self.moveDirection[1],2) + math.exp(self.moveDirection[2],2))
        local moveMagnitudeNomalized =  {self.moveDirection[1] /moveMagnitude, self.moveDirection[2]/moveMagnitude}

        self.x = self.x + moveMagnitudeNomalized[1]*self.moveSpeed
        self.y = self.y + moveMagnitudeNomalized[2]*self.moveSpeed
        self.body:setPosition(self.x, self.y)
    end

end