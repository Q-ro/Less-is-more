--	#################################################
--	# Title:		player.lua					    #
--	# Author:		Andres Mrad (Q-ro)			    #
--	# Date:			Dec 04 2017					    #
--	# Description:	Defines the player controller   #
--	#################################################


Player = {}
Player.__index = Player


local lg = love.graphics

--- Constructor for te player object
function Player.create(posX,posY,maxMoveSpeed)

    local self = setmetatable({}, Player)

    self.x = posX;
    self.y = posY;
    self.maxMoveSpeed = maxMoveSpeed
    self.currentMoveSpeed = maxMoveSpeed
    self.maxMoveSpeed = maxMoveSpeed
    
    self.Animation = {}

    self:loadAnimation("AnimationRunUp","Assets/Images/run_up.png",96,96,0.2)
    self:loadAnimation("AnimationRunDown","Assets/Images/run_down.png",96,96,0.2)
    self:loadAnimation("AnimationRunLeft","Assets/Images/run_left.png",96,96,0.2)
    self:loadAnimation("AnimationRunRight","Assets/Images/run_right.png",96,96,0.2)
    self:loadAnimation("AnimationIdel","Assets/Images/idle.png",96,96,0.5)

    --The default animation to pay
    self.currentAnimation = self.Animation["AnimationIdel"]

    self.shape = love.physics.newCircleShape(24)  -- circle with radius 24
    self.body = love.physics.newBody(world, posX, posY, "kinematic")
    self.fix = love.physics.newFixture(self.body, self.shape, 5)
    self.fix:setUserData("player")

    return self

end

function Player:draw()

    --lg.setColor(255, 0, 0)
    --lg.circle("line", self.body:getX(),self.body:getY(), self.shape:getRadius(), 20)
    lg.setColor(255, 255, 255)


    --love.graphics.polygon("line", static.b:getWorldPoints(static.s:getPoints()))

    local spriteNum = math.floor(self.currentAnimation.currentTime / self.currentAnimation.duration * #self.currentAnimation.Quads) + 1
    lg.draw(self.currentAnimation.spriteSheet, self.currentAnimation.Quads[spriteNum], self.body:getX()-46, self.body:getY()-60, 0, 1)

end

function Player:update(dt)

        self.currentAnimation.currentTime = self.currentAnimation.currentTime + dt
        if self.currentAnimation.currentTime >= self.currentAnimation.duration then
            self.currentAnimation.currentTime = self.currentAnimation.currentTime - self.currentAnimation.duration
        end

        self:move()

end

function Player:updateSpeed(x)
    self.currentMoveSpeed = clamp(self.currentMoveSpeed*10 + x*10, 0, self.maxMoveSpeed*10)/10

end

function Player:getSpeed()
    return self.currentMoveSpeed
end

function Player:move()

    self.currentAnimation = self.Animation["AnimationIdel"]

    -- Update position
    local x, y = player.body:getPosition()
    
   -- if k == "up" then
    if love.keyboard.isDown("w") then
        if (self.y > 45) then
            self.y = (self.y - self.currentMoveSpeed)
            self.currentAnimation = self.Animation["AnimationRunUp"]
        end 
    elseif love.keyboard.isDown("s") then
        if (self.y < lg.getHeight() -110) then
            self.y = (self.y + self.currentMoveSpeed) 
            self.currentAnimation = self.Animation["AnimationRunDown"]
        end
    end

    if love.keyboard.isDown("a") then
        if (self.x > 40) then
            self.x = (self.x - self.currentMoveSpeed) 
            self.currentAnimation = self.Animation["AnimationRunRight"]
        end
    elseif love.keyboard.isDown("d") then
        if (self.x < lg.getWidth() -40) then
            self.x = (self.x + self.currentMoveSpeed) 
            self.currentAnimation = self.Animation["AnimationRunLeft"]
        end
     end
     --self.body:setX(self.x)
     --self.body:setY(self.y)
     self.body:setPosition(self.x, self.y)

end

function Player:loadAnimation(animationHolder,image, width, height, duration)
    self.Animation[animationHolder] = {}
    self.Animation[animationHolder] = loadAnimation(image, width, height, duration)
end

