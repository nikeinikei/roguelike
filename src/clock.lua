--A class for a clock object to keep track of elapsed Time
local Clock = {}
Clock.__index = Clock

function Clock:new()
    local o = {}
    setmetatable(o, self)
    self.startTime = love.timer.getTime()
    return o
end

function Clock:getElapsedTime()
    return love.timer.getTime() - self.startTime
end

function Clock:restart()
    local elapsedTime = love.timer.getTime() - self.startTime
    self.startTime = love.timer.getTime()
    return elapsedTime
end

function Clock:add(time)
    self.startTime = self.startTime - time
end

return Clock
