
platform = {}
platform.__index = platform


--- Constructor for the platform object
-- @width: Platform width
-- @height: Platform height
-- @x: Position in X
-- @y: Position in Y
function platform.create( width, height, x, y )
    local self = setmetatable({}, platform)
    
    self.Width = width
    self.Height = height

    -- This is the coordinates where the platform will be rendered.
    self.X = x                               -- This starts drawing the platform at the left edge of the game window.
    self.Y = y             -- This starts drawing the platform at the very middle of the game window

end

function platform.load()

end


function platform.draw()

end