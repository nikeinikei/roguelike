local settings = require "settings"
local grid = require "grid"

local Player = {}
Player.__index = Player

local w = settings.player.w
local h = settings.player.h
local x = settings.startingTile.gridx * settings.gridwidth + (settings.gridwidth / 2)
local y = settings.startingTile.gridy * settings.gridwidth + (settings.gridwidth / 2)
local v = 400

function Player:new(world)
    local o = {}
    setmetatable(o, self)
    o.x = x
    o.y = y
    o.gridx, o.gridy = grid:getGridCoords(o.x, o.y)
    o.world = world
    o.direction = 0
    o.name = "player"
    world:add(o, x, y, w, h)
    return o
end

local function filter(_, other)
    if other.name == "shot" then
        return 'cross'
    end
    if other.name == "wall" then
        return "slide"
    end
    if other.name == "partialDoorObject" then
        return "slide"
    end
    if other.name == "door" then
        return "cross"
    end
end

local dx, dy
function Player:update(dt)
    dx, dy = 0, 0
    if love.keyboard.isDown("up") then
        dy = dy - (v * dt)
    end
    if love.keyboard.isDown("right") then
        dx = dx + (v * dt)
    end
    if love.keyboard.isDown("down") then
        dy = dy + (v * dt)
    end
    if love.keyboard.isDown("left") then
        dx = dx - (v * dt)
    end
    --update player.gridx, player.gridy
    self:updateDirection(dx, dy)
    local cols, len
    self.x, self.y, cols, len = self.world:move(self, self.x + dx, self.y + dy, filter)
    self.gridx, self.gridy = grid:getGridCoords(self:getCenter())
    for _, v in pairs(cols) do
        local other = v.other
        if other.name == "door" then
            local gridx, gridy = other.gridx, other.gridy
            if other.orientation == "top" then
                self.world:remove(other)
                return gridx, gridy - 1
            end
            if other.orientation == "right" then
                self.world:remove(other)
                return gridx + 1, gridy
            end
            if other.orientation == "lower" then
                self.world:remove(other)
                return gridx, gridy + 1
            end
            if other.orientation == "left" then
                self.world:remove(other)
                return gridx - 1, gridy
            end
            error("no fitting direction")
        end
    end
    return nil --redundant, like me
end

--the direction starts at 0 at east, an increase of one correlates to a 45° rotation 
--this was done to make calculations in shots.lua easier
function Player:updateDirection(dx, dy)
    if dx > 0 then
        if dy > 0 then
            self.direction = 1
        elseif dy == 0 then
            self.direction = 0
        else
            self.direction = 7
        end
    elseif dx == 0 then
        if dy > 0 then
            self.direction = 2
        else
            self.direction = 6
        end
    else
        if dy > 0 then
            self.direction = 3
        elseif dy == 0 then
            self.direction = 4
        else
            self.direction = 5
        end
    end
end

function Player:draw()
    love.graphics.setColor(220, 220, 220, 255)
    love.graphics.rectangle("fill", self.x, self.y, w, h)
end

function Player:getPosition()
    return self.x, self.y
end

function Player:getDimensions()
    return w, h
end

function Player:destroy()
    self.world:remove(self)
end

function Player:getCenter()
    return self.x + (w / 2), self.y + (h / 2)
end

return Player
