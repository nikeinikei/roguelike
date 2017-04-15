local settings = require "settings"
local grid = require "grid"

local Player = {}
Player.__index = Player

local w = 30
local h = 30
local x = settings.startingTile.gridx * settings.gridwidth + (settings.gridwidth / 2)
local y = settings.startingTile.gridy * settings.gridwidth + (settings.gridwidth / 2)
local v = 400

local dx, dy

local counter = 1
local function getPlayerId()
    local playerId = "player-" .. counter
    counter = counter + 1
    return playerId
end

function Player:new(world)
    local o = {}
    setmetatable(o, self)
    o.id = getPlayerId()
    o.x = x
    o.y = y
    o.gridx, o.gridy = grid:getGridCoords(o.x, o.y)
    o.world = world
    world:add(o.id, x, y, w, h)
    return o
end

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
    local cols, len
    self.x, self.y, cols, len = self.world:move(self.id, self.x + dx, self.y + dy)
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
    self.world:remove(self.id)
end

function Player:getCenter()
    return self.x + (w/2), self.y + (h/2)
end

return Player
