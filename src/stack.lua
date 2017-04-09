
--implementation of the data type stack in lua
--push(element): pushes an element on top of the stack
--pop(): pops the topmost element off the stack and returns it#
--top(): returns the element on the top

Stack = {
    stack = {}
}

function Stack:new(o)
    o = o or self
    setmetatable(o, self)
    self.__index = self
    o.stack = {}
    return o
end

function Stack:push(element)
    table.insert(self.stack, element)
end

function Stack:pop()
    return table.remove(self.stack)
end

function Stack:top()
    return self.stack[table.maxn(self.stack)]
end
