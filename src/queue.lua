local Queue = {}
local Queue_mt = {__index = Queue}

function Queue:new(t)
    local self = {}
    setmetatable(self, Queue_mt)
    self.queue = t or {}
    return self
end

function Queue:peek()
    return self.queue[1]
end

function Queue:poll()
    return table.remove(self.queue, 1)
end

function Queue:add(obj)
    table.insert(self.queue, obj)
end

function Queue:isEmpty()
    return #self.queue == 0
end

return Queue
