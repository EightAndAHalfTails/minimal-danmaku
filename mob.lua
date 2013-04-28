module(..., package.seeall);

require "object"
require "entity"

Mob = object.create({lives     = nil,
                     health    = nil,
                     maxhealth = nil,
                     dead      = nil},
                    entity.Entity)

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
      self.health = self.maxhealth
      self.lives = self.lives - 1
      self.dead = self.lives < 0
   end
end