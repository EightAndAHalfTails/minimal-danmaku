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

Boss = object.create({},
		     Enemy)

function Boss:draw()
   self.super:draw()
   print("drawing")
   local maxwidth = globals.MAX_X - 60
   local width    = maxwidth * self.health / self.maxhealth 

   r, g, b, a = love.graphics.getColor()
   love.graphics.setColor(0,0,0,128)
   love.graphics.rectangle('fill', 10, 30, maxwidth, 30)
   love.graphics.setColor(255,0,0,0)
   love.graphics.rectangle('fill', 10, 30, width, 30)
   love.graphics.setColor(r,g,b,a)
end