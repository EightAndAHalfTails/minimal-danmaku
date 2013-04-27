module(..., package.seeall);

Entity = {
x = 0,
y = 0
}
Entity_mt = { __index = Entity }

-- This function creates a new instance of Entity
--
function Entity:create()
    local new_inst = {}    -- the new instance
    setmetatable( new_inst, Entity_mt ) -- all instances share the same metatable
    return new_inst
end

function Entity:update()
--whatever
end

function Entity:draw()
--draw
end

function Entity:inheritFrom(SubClass)
   
end