module(..., package.seeall);

require "entity"

Mob = {}

function Mob:create()
   local new_inst = {super     = entity.Entity:create(),
                     lives     = nil,
                     health    = nil,
                     maxhealth = nil,
                     dead      = nil}

   setmetatable(new_inst, { __index = new_inst.super })

   for k, v in pairs(Mob) do
      new_inst[k] = v
   end

   return new_inst
end

function Mob:initialise(x, y, sprite, hwidth, hheight, power, lives, health)
   self.super:initialise(x, y, sprite, hwidth, hheight, power)

   self.lives     = lives
   self.health    = health
   self.maxhealth = health
   self.dead      = false
end

function Mob:emit()
   error("emit unimplemented")
end

function Mob:damage(amount)
   self.health = self.health - damage

   if self.health < 0 then
      self.health = self.maxhealth
      self.lives = self.lives - 1
      self.dead = self.lives < 0
   end
end