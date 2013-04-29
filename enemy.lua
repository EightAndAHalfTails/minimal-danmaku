module (..., package.seeall)

require "object"
require "mob"

Enemy = object.create({delay = 0,
                       timer = 0,
                       worth = nil},
                      mob.Mob)

function Enemy:initialise(x, y, sprite, hwidth, hheight, power, health, worth)
   self.super:initialise(x, y, sprite, hwidth, hheight, power, 1, health)

   self.bsprite = bsprite
   self.worth = worth
end

function Enemy:update(dt)
   self.timer = self.timer + dt
end
