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
local Wall_mt = {__index = Wall}

function Wall:new(world, gridx, gridy, orientation)
    local self = {}
    setmetatable(self, Wall_mt)
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
    self.gridx = gridx
    self.gridy = gridy
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.gridx = gridx
    self.gridy = gridy
    self.orientation = orientation
    self.world = world
    self.name = "wall"
    world:add(self, x, y, w, h)
    return self
end

local grid = require "grid"
function Wall:isOpen()
    local orientation = self.orientation
    if orientation == "top" then
        return grid:get(self.gridx, self.gridy - 1) == false
    end
    if orientation == "right" then
        return grid:get(self.gridx + 1, self.gridy) == false
    end
    if orientation == "lower" then
        return grid:get(self.gridx, self.gridy + 1) == false
    end
    if orientation == "left" then
        return grid:get(self.gridx - 1, self.gridy) == false
    end
    error("this error shouldnt happen.")
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
    self.world:remove(self)
end

function Wall:getWidth()
    return wallWdith
end

return Wall
