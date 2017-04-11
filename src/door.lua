local player = require "player"
local settings = require "settings"
local unit = settings.gridwidth
local unithalf = unit / 2 --convenience
local Wall = require "wall"
local wallWidth = Wall:getWidth() --width same width as the wall
local wallColor = Wall:getColor()

local padding = 20
local width = player:getWidth() + (padding * 2)
--convenience variables
local offset = (unit / 2) - (width / 2)
local offsetHalf = offset / 2

local Door = {}
Door.__index = Door

local counter = 1
local function getDoorIds()
    local leftDoorId = "door-left-" .. counter
    local rightDoorId = "door-right-" .. counter
    return leftDoorId, rightDoorId
end

function Door:new(world, gridx, gridy, orientation)
    local o = {}
    setmetatable(o, self)
    local lowerx = gridx * unit
    local lowery = gridy * unit
    local success = false
    local leftDoorId, rightDoorId = getDoorIds()
    if orientation == "top" then
        world:add(leftDoorId, lowerx, lowery - (wallWidth / 2), offset, wallWidth)
        world:add(rightDoorId, lowerx + unit - offset, lowery - (wallWidth / 2), offset, wallWidth)
        success = true
    end
    if orientation == "right" then
        world:add(leftDoorId, lowerx + unit - (wallWidth / 2), lowery, wallWidth, offset)
        world:add(rightDoorId, lowerx + unit - (wallWidth / 2), lowery + unit - offset, wallWidth, offset)
        success = true
    end
    if orientation == "lower" then
        world:add(leftDoorId, lowerx, lowery - (wallWidth / 2) + unit, offset, wallWidth)
        world:add(rightDoorId, lowerx + unit - offset, lowery - (wallWidth / 2) + unit, offset, wallWidth)
        success = true
    end
    if orientation == "left" then
        world:add(leftDoorId, lowerx - (wallWidth / 2), lowery, wallWidth, offset)
        world:add(rightDoorId, lowerx - (wallWidth / 2), lowery + unit - offset, wallWidth, offset)
        success = true
    end
    if success == false then
        local errormessage = "invalid orientation: \"" .. orientation .. "\""
        error(errormessage)
    end
    o.leftDoorId = leftDoorId
    o.rightDoorId = rightDoorId
    o.x = gridx
    o.y = gridy
    o.orientation = orientation
    return o
end

local c = wallColor
function Door:draw()
    love.graphics.setColor(c.r, c.g, c.b, c.a)
    local rightx, righty
end

function Door:destroy()
end

return Door
