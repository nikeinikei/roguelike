local settings = require "settings"
local unit = settings.gridwidth
local halfunit = unit / 2

--the interface table
local Grid = {}

--the value table
local grid = {}

function Grid:reset()
    grid = {}
end

function Grid:set(x, y)
    if grid[x] == nil then
        grid[x] = {}
    end
    grid[x][y] = true
end

function Grid:get(x, y)
    if grid[x] == nil then
        return false
    else
        if grid[x][y] == true then
            return true
        else
            return false
        end
    end
end

function Grid:delete(x, y)
    if grid[x] ~= nil then
        grid[x][y] = nil
    end
end

function Grid:deleteColumn(x)
    grid[x] = nil
end

function Grid:deleteRow(y)
    for k, v in pairs(grid) do
        if grid[k][y] ~= nil then
            grid[k][y] = nil
        end
    end
end

function Grid:draw()
    for kx, vx in pairs(grid) do
        for ky, vy in pairs(vx) do
            local x = kx * unit
            local y = ky * unit
            love.graphics.setColor(150, 150, 255, 127)
            love.graphics.rectangle("fill", x, y, unit, unit)
            love.graphics.setColor(255, 255, 255, 255)
            local coords = "(" .. kx .. ", " .. ky .. ")"
            --love.graphics.print(coords, x + halfunit - 40, y + halfunit - 40)
        end
    end
end

function Grid:print()
    for kx, vx in pairs(grid) do
        for ky, vy in pairs(vx) do
            print(kx, ky, vy)
        end
    end
end

return Grid
