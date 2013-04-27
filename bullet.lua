module(..., package.seeall);

require "entity"

Bullet = {}

function Bullet:create()
   local new_inst = {super  = entity.Entity:create(),
                     player = nil,
                     step   = nil}

   setmetatable(new_inst, { __index = new_inst.super })

   for k, v in pairs(Bullet) do
      new_inst[k] = v
   end

   return new_inst
end

function Bullet:initialise(x, y, sprite, power, player, step)
   self.super:initialise(x, y, sprite, sprite:getWidth(), sprite:getHeight(), power)

   self.player = player
   self.step   = step
end

function Bullet:collide(target)
   target.damage(self.power)
end
