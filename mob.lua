module(..., package.seeall);

require "entity"

Mob = {
   super     = entity.Entity,
   lives     = nil,
   health    = nil,
   maxhealth = nil,
   dead      = nil
}

Mob_mt = { __index = Mob }
setmetatable(Mob, entity.Entity_mt)

function Mob:create()
   local new_inst = {}
   setmetatable(new_inst, Mob_mt)

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