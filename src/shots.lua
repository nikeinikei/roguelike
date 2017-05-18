local Shot = require "shot"

local Shots = {}

local shots
local v = 400

function Shots:reset()
    shots = {}
end

function Shots:add(world, x, y, direction)
    print(world, x, y, direction)
    local a = 0
    while direction > 0 do
        a = a + 45
        direction = direction - 1
    end
    table.insert(shots, Shot:new(world, x, y, a, v))
end

function Shots:update(dt)
    for k, v in pairs(shots) do
        local shouldBeDestroyed = v:update(dt)
        if shouldBeDestroyed then
            v:destroy()
            table.remove(shots, k)
        end
    end
end

function Shots:draw()
    for _, v in pairs(shots) do
        v:draw()
    end
end

function Shots:destroy()
    for _, v in pairs(shots) do
        v:destroy()
    end
end

return Shots
