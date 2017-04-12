local settings = require "settings"
local unit = settings.gridwidth
local halfunit = unit / 2

--the wall width also determines how much farther the wall should extends (due to having a width > 1)
local wallWdith = 6
local halfWidth = wallWdith / 2

local wallColor = {
    r = 255,
    g = 255,
    b = 255,
    a = 255
}

local Wall = {}
Wall.__index = Wall

local counter = 1
local function getWallId()
    local wallid = "wall-" .. counter
    counter = counter + 1
    return wallid
end

function Wall:new(world, gridx, gridy, orientation)
    local o = {}
    setmetatable(o, self)
    local lowerx = gridx * unit
    local lowery = gridy * unit
    local success = false
    local x, y, w, h
    if orientation == "top" then
        x, y, w, h = lowerx, lowery - halfWidth, unit, wallWdith
        success = true
    end
    if orientation == "right" then
        x, y, w, h = lowerx + unit - halfWidth, lowery, wallWdith, unit
        success = true
    end
    if orientation == "lower" then
        x, y, w, h = lowerx, lowery + unit - halfWidth, unit, wallWdith
        success = true
    end
    if orientation == "left" then
        x, y, w, h = lowerx - halfWidth, lowery, wallWdith, unit
        success = true
    end
    if success == false then
        local errormessage = "invalid orientation: \"" .. orientation .. "\""
        error(errormessage)
    end
    o.wallId = getWallId()
    world:add(o.wallId, x, y, w, h)
    o.gridx = gridx
    o.gridy = gridy
    o.x = x
    o.y = y
    o.w = w
    o.h = h
    o.gridx = gridx
    o.gridy = gridy
    o.orientation = orientation
    o.world = world
    return o
end

local c = wallColor
function Wall:draw()
    love.graphics.setColor(c.r, c.g, c.b, c.a)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

function Wall:getColor()
    return wallColor
end

function Wall:destroy()
    self.world:remove(self.wallId)
end

function Wall:getWidth()
    return wallWdith
end

return Wall
