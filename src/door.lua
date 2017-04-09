local player = require "player"
local settings = require "settings"
local unit = settings.gridwidth
local unithalf = unit / 2   --convenience
local Wall = require "wall"
local wallWidth = Wall:getWidth()   --width same width as the wall

local padding = 20
local width = player:getWidth() + (padding * 2)
--convenience variables
local offset = (unit / 2) - (width / 2)
local offsetHalf = offset / 2

local Door = {}
Door.__index = Door

function Door:new(world, gridx, gridy, orientation)
    print(world, gridx, gridy, orientation)
    local o = {}
    setmetatable(o, self)
    local lowerx = gridx * unit
    local lowery = gridy * unit
    local left = {}
    local right = {}
    local door = {}
    local success = false
    if orientation == "top" then
        left.body = love.physics.newBody(world, lowerx + offsetHalf, lowery, "static")
        left.shape = love.physics.newRectangleShape(offset, wallWidth)
        right.body = love.physics.newBody(world, lowerx + unit - offsetHalf, lowery, "static")
        right.shape = love.physics.newRectangleShape(offset, wallWidth)
        door.body = love.physics.newBody(world, lowerx + unithalf, lowery, "static")
        door.shape = love.physics.newRectangleShape(width, 1)
        success = true
    end
    if orientation == "right" then
        left.body = love.physics.newBody(world, lowerx + unit, lowery + offsetHalf, "static")
        left.shape = love.physics.newRectangleShape(wallWidth, offset)
        right.body = love.physics.newBody(world, lowerx + unit, lowery + unit - offsetHalf, "static")
        right.shape = love.physics.newRectangleShape(wallWidth, offset)
        door.body = love.physics.newBody(world, lowerx + unit, lowery + unithalf, "static")
        door.shape = love.physics.newRectangleShape(1, width)
        success = true
    end
    if orientation == "lower" then
        left.body = love.physics.newBody(world, lowerx + offsetHalf, lowery + unit, "static")
        left.shape = love.physics.newRectangleShape(offset, wallWidth)
        right.body = love.physics.newBody(world, lowerx + unit - offsetHalf, lowery + unit, "static")
        right.shape = love.physics.newRectangleShape(offset, wallWidth)
        door.body = love.physics.newBody(world, lowerx + unithalf, lowery + unit, "static")
        door.shape = love.physics.newRectangleShape(width, 1)
        success = true
    end
    if orientation == "left" then
        left.body = love.physics.newBody(world, lowerx, lowery + offsetHalf, "static")
        left.shape = love.physics.newRectangleShape(wallWidth, offset)
        right.body = love.physics.newBody(world, lowerx, lowery + unit - offsetHalf, "static")
        right.shape = love.physics.newRectangleShape(wallWidth, offset)
        door.body = love.physics.newBody(world, lowerx, lowery + unithalf, "static")
        door.shape = love.physics.newRectangleShape(1, width)
        success = true
    end
    if success == false then
        local errormessage = "invalid orientation: \"" .. orientation .. "\""
        error(errormessage)
    end
    right.fixture = love.physics.newFixture(right.body, right.shape)
    right.fixture:setUserData("doorwall")
    left.fixture = love.physics.newFixture(left.body, left.shape)
    left.fixture:setUserData("doorwall")
    door.fixture = love.physics.newFixture(door.body, door.shape)
    door.fixture:setUserData("door")
    o.right = right
    o.left = left
    o.door = door
    o.x = gridx
    o.y = gridy
    o.orientation = orientation
    return o
end


function Door:draw()
    love.graphics.setColor(255,255,255,255)
    local left = self.left
    local right = self.right
    local door = self.door
    love.graphics.polygon("fill", left.body:getWorldPoints(left.shape:getPoints()))
    love.graphics.polygon("fill", right.body:getWorldPoints(right.shape:getPoints()))
    love.graphics.setColor(127,56, 244, 255)
    love.graphics.polygon("fill", door.body:getWorldPoints(door.shape:getPoints()))
end


local util = require "util"
local safeDestroy = util.safeDestroy

function Door:destroy()
    safeDestroy(right)
    safeDestroy(left)
    safeDestroy(door)
end

return Door
