local settings = require "settings"
local unit = settings.gridwidth
local halfunit = unit / 2

--the wall width also determines how much farther the wall should extends (due to having a width > 1)
local wallWdith = 6

local wallColor = {
    r = 255,
    g = 255,
    b = 255,
    a = 255
}

local Wall = {}
Wall.__index = Wall

function Wall:new(world, gridx, gridy, orientation)
    local o = {}
    setmetatable(o, self)
    local lowerx = gridx * unit
    local lowery = gridy * unit
    local success = false
    if orientation == "top" then
        o.body = love.physics.newBody(world, lowerx + halfunit, lowery, "static")
        o.shape = love.physics.newRectangleShape(unit + wallWdith, wallWdith)
        success = true
    end
    if orientation == "right" then
        o.body = love.physics.newBody(world, lowerx + unit, lowery + halfunit, "static")
        o.shape = love.physics.newRectangleShape(wallWdith, unit + wallWdith)
        success = true
    end
    if orientation == "lower" then
        o.body = love.physics.newBody(world, lowerx + halfunit, lowery + unit, "static")
        o.shape = love.physics.newRectangleShape(unit + wallWdith, wallWdith)
        success = true
    end
    if orientation == "left" then
        o.body = love.physics.newBody(world, lowerx, lowery + halfunit, "static")
        o.shape = love.physics.newRectangleShape(wallWdith, unit + wallWdith)
        success = true
    end
    if success == false then
        local errormessage = "invalid orientation: \"" .. orientation .. "\""
        error(errormessage)
    end
    o.fixture = love.physics.newFixture(o.body, o.shape, 1)
    o.fixture:setUserData("wall")
    o.x = gridx
    o.y = gridy
    o.orientation = orientation
    return o
end

function Wall:draw()
    local c = wallColor
    love.graphics.setColor(c.r, c.g, c.b, c.a)
    love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end

function Wall:destroy()
    --safe destroy
    if self.body:isDestroyed() == false then 
        self.body:destroy() 
    end
    if self.fixture:isDestroyed() == false then 
        self.fixture:destroy()
    end
end

function Wall:getWidth()
    return wallWdith
end

return Wall
