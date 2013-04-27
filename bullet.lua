module(..., package.seeall);

require "object"
require "entity"

Bullet = object.create({player = nil,
                        step   = nil},
                       entity.Entity)

function Bullet:initialise(x, y, sprite, power, player, step)
   self.super:initialise(x, y, sprite, sprite:getWidth(), sprite:getHeight(), power)

   self.player = player
   self.step   = step
end

function Bullet:collide(target)
   target.damage(self.power)
end
