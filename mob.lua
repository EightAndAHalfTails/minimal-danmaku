module(..., package.seeall);

require "object"
require "entity"
require "explosion"
require "globals"

Mob = object.create(entity.Entity)

Mob.lives     = nil
Mob.health    = nil
Mob.maxhealth = nil
Mob.dead      = false

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
   self.health = self.health - amount
   if self.health <= 0 then
      self:onDeath()
      return true
   end
end

function Mob:onDeath()
   self.lives = self.lives - 1
   self.health = self.maxhealth
   self.dead = self.lives < 0

   self:explode()
end

function Mob:explode()
   local exp = explosion.Explosion:new(self.x, self.y)
   table.insert(globals.explosions, exp)
end