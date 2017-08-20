--A class for a clock object to keep track of elapsed Time
local Clock = {}
local Clock_mt = {__index = Clock}

function Clock:new()
    local self = {}
    setmetatable(self, Clock_mt)
    self.startTime = love.timer.getTime()
    return self
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
