module(..., package.seeall);

require "object"
require "entity"

Bullet = object.create({player = nil,
                        step   = nil,
                        bomb   = nil},
                       entity.Entity)

function Bullet:initialise(x, y, sprite, power, player, bomb, step)
   self.super:initialise(x, y, sprite, sprite:getWidth(), sprite:getHeight(), power)

   self.player = player
   self.bomb   = bomb
   self.step   = step
end

function Bullet:collide(target)
   target:damage(self.power)
end
