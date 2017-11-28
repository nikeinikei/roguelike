--implementation of the data type stack in lua
--push(element): pushes an element on top of the stack
--pop(): pops the topmost element off the stack and returns it#
--top(): returns the element on the top

local Stack = Object:extend()

function Stack:new()
    self.stack = {}
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

return Stack
