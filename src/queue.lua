local Queue = Object:extend()

function Queue:new(t)
    self.queue = t or {}
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
