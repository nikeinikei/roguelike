--shows inheritance of a gamestate from the base class gamestate
--the functions of the base class can be overridden here

local Gamestate = require "gamestate"
local grid = require "grid"
local player = require "player"
local Room = require "room"
local camera = require "camera"

local world
local room

local PlayingState = Gamestate:new()
PlayingState.__index = PlayingState

function PlayingState:new(application)
    local o = {}
    setmetatable(o, self)
    o:setApp(application)
    --reset plane
    love.graphics.origin()

    world = love.physics.newWorld()
    room = Room:new(world, 2, 2)

    return o
end

function PlayingState:update(dt)
    world:update(dt)
    player:update(dt)
    camera:update()
end

function PlayingState:draw()
    camera:apply()

    grid:draw()
    player:draw()
    room:draw()

    --reset the transformations done by the camera
    love.graphics.origin()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print(love.timer.getFPS())
end

function PlayingState:keypressed(key, code, isRepeat)
    if key == "escape" then
        love.event.quit()
    end
end

function PlayingState:quit()
end

return PlayingState
