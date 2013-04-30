module (..., package.seeall)

require "object"
require "mob"
require "explosion"
require "globals"

Enemy = object.create({delay = 0,
                       timer = 0,
                       worth = nil},
                      mob.Mob)

function Enemy:initialise(x, y, sprite, hwidth, hheight, power, health, worth)
   self.super:initialise(x, y, sprite, hwidth, hheight, power, 0, health)

   self.bsprite = bsprite
   self.worth = worth
end

function Enemy:update(dt)
   self.timer = self.timer + dt
end

function Enemy:explode()
   local exp = explosion.Explosion:new(self.x, self.y, self.worth)
   table.insert(globals.explosions, exp)
   globals.player.score = globals.player.score + self.worth
end