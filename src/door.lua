local player = require "player"
local settings = require "settings"
local unit = settings.gridwidth
local unithalf = unit / 2 --convenience
local Wall = require "wall"
local wallWidth = Wall:getWidth() --width same width as the wall
local wallColor = Wall:getColor()

local padding = 20
local width = select(1, player:getDimensions()) + (padding * 2)
--convenience variables
local offset = (unit / 2) - (width / 2)
local offsetHalf = offset / 2

local Door = {}
Door.__index = Door

local counter = 1
local function getDoorIds()
    local leftDoorId = "door-left-" .. counter
    local rightDoorId = "door-right-" .. counter
    counter = counter + 1
    return leftDoorId, rightDoorId
end

function Door:new(world, gridx, gridy, orientation)
    local o = {}
    setmetatable(o, self)
    local lowerx = gridx * unit
    local lowery = gridy * unit
    local success = false
    local leftDoorId, rightDoorId = getDoorIds()
    local left = {}
    local right = {}
    local door = {}
    if orientation == "top" then
        left.x, left.y, left.w, left.h = lowerx, lowery - (wallWidth / 2), offset, wallWidth
        right.x, right.y, right.w, right.h = lowerx + unit - offset, lowery - (wallWidth / 2), offset, wallWidth
        door.x, door.y, door.w, door.h = lowerx + offset, lowery, width, 1
        success = true
    end
    if orientation == "right" then
        left.x, left.y, left.w, left.h = lowerx + unit - (wallWidth / 2), lowery, wallWidth, offset
        right.x, right.y, right.w, right.h = lowerx + unit - (wallWidth / 2), lowery + unit - offset, wallWidth, offset
        door.x, door.y, door.w, door.h = lowerx + unit, lowery + offset, 1, width
        success = true
    end
    if orientation == "lower" then
        left.x, left.y, left.w, left.h = lowerx, lowery - (wallWidth / 2) + unit, offset, wallWidth
        right.x, right.y, right.w, right.h = lowerx + unit - offset, lowery - (wallWidth / 2) + unit, offset, wallWidth
        door.x, door.y, door.w, door.h = lowerx + offset, lowery + unit, width, 1
        success = true
    end
    if orientation == "left" then
        left.x, left.y, left.w, left.h = lowerx - (wallWidth / 2), lowery, wallWidth, offset
        right.x, right.y, right.w, right.h = lowerx - (wallWidth / 2), lowery + unit - offset, wallWidth, offset
        door.x, door.y, door.w, door.h = lowerx, lowery + offset, 1, width
        success = true
    end
    if success == false then
        local errormessage = "invalid orientation: \"" .. orientation .. "\""
        error(errormessage)
    end
    world:add(leftDoorId, left.x, left.y, left.w, left.h)
    world:add(rightDoorId, right.x, right.y, right.w, right.h)
    world:add(o, door.x, door.y, door.w, door.h)
    o.door = door
    o.world = world
    o.left = left
    o.right = right
    o.leftDoorId = leftDoorId
    o.rightDoorId = rightDoorId
    o.gridx = gridx
    o.gridy = gridy
    o.orientation = orientation
    o.name = "door"
    return o
end

local c = wallColor
function Door:draw()
    love.graphics.setColor(c.r, c.g, c.b, c.a)
    local left, right = self.left, self.right
    love.graphics.rectangle("fill", left.x, left.y, left.w, left.h)
    love.graphics.rectangle("fill", right.x, right.y, right.w, right.h)
end

function Door:destroy()
    self.world:remove(self.leftDoorId)
    self.world:remove(self.rightDoorId)
end

return Door
