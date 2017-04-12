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
    print("new door with parameters: ", world, gridx, gridy, orientation)
    local o = {}
    setmetatable(o, self)
    local lowerx = gridx * unit
    local lowery = gridy * unit
    local success = false
    local leftDoorId, rightDoorId = getDoorIds()
    local left = {}
    local right = {}
    if orientation == "top" then
        left.x, left.y, left.w, left.h = lowerx, lowery - (wallWidth / 2), offset, wallWidth
        right.x, right.y, right.w, right.h = lowerx + unit - offset, lowery - (wallWidth / 2), offset, wallWidth
        success = true
    end
    if orientation == "right" then
        left.x, left.y, left.w, left.h = lowerx + unit - (wallWidth / 2), lowery, wallWidth, offset
        right.x, right.y, right.w, right.h = lowerx + unit - (wallWidth / 2), lowery + unit - offset, wallWidth, offset
        success = true
    end
    if orientation == "lower" then
        left.x, left.y, left.w, left.h = lowerx, lowery - (wallWidth / 2) + unit, offset, wallWidth
        right.x, right.y, right.w, right.h = lowerx + unit - offset, lowery - (wallWidth / 2) + unit, offset, wallWidth
        success = true
    end
    if orientation == "left" then
        left.x, left.y, left.w, left.h = lowerx - (wallWidth / 2), lowery, wallWidth, offset
        right.x, right.y, right.w, right.h = lowerx - (wallWidth / 2), lowery + unit - offset, wallWidth, offset
        success = true
    end
    if success == false then
        local errormessage = "invalid orientation: \"" .. orientation .. "\""
        error(errormessage)
    end
    print("leftdoorrectangle: ", left.x, left.y, left.w, left.h)
    print("rightdoorrectangle: ", right.x, right.y, right.w, right.h)
    world:add(leftDoorId, left.x, left.y, left.w, left.h)
    world:add(rightDoorId, right.x, right.y, right.w, right.h)
    o.world = world
    o.left = left
    o.right = right
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
    local left, right = self.left, self.right

    love.graphics.rectangle("fill", left.x, left.y, left.w, left.h)
    love.graphics.rectangle("fill", right.x, right.y, right.w, right.h)
end

function Door:destroy()
    self.world:remove(self.leftDoorId)
    self.world:remove(self.rightDoorId)
end

return Door
