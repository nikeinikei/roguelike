--all global variables are declared here

--the Object class every other class will inherit from
Object = require "classic"





--disallow creation of new global variables
--to make the code safe
setmetatable(_G, {__newindex = function()
    error("no global variables allowed")
end})