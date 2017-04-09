local Queue = {}
Queue.__index = Queue

function Queue:new(t)
    local o = {}
    setmetatable(o, self)
    o.queue = t or {}
    return o
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
