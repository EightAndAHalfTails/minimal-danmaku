module(..., package.seeall);

require "entity"

Mob = {}
Mob_mt = { __index = Mob }
setmetatable(Mob, entity.Entity_mt)

function Mob:create()
   --local newinst = entity.Entity:create()
   local newinst = {}
   --setmetatable( newinst, entity.Entity_mt )
   setmetatable(newinst, Mob_mt)
   return newinst
end

function Mob:checkCollide(target)
end