module (..., package.seeall)

require "object"
require "mob"
require "explosion"
require "globals"

Enemy = object.create(mob.Mob)

Enemy.delay = 0
Enemy.timer = 0
Enemy.worth = nil

function Enemy:initialise(x, y, sprite, hwidth, hheight, power, health, worth)
   self.super:initialise(x, y, sprite, hwidth, hheight, power, 0, health)

   self.bsprite = bsprite
   self.worth = worth
end

function Enemy:update(dt)
   self.timer = self.timer + dt
end

function Enemy:explode()
   local exp = explosion.Explosion(self.x, self.y, self.worth)
   table.insert(globals.explosions, exp)

   local sfx = love.audio.newSource(resources.sfx["explosion.ogg"])
   love.audio.play(sfx)

   globals.player.score = globals.player.score + self.worth
end

Boss = object.create(Enemy)

function Boss:draw()
   self.super:draw()

   local y = globals.MAX_Y - 20
   local maxwidth = globals.MAX_X - 20
   local width    = maxwidth * self.health / self.maxhealth 

   r, g, b, a = love.graphics.getColor()
   love.graphics.setColor(0,0,0,128)
   love.graphics.rectangle('fill', 10, y, maxwidth, 10)
   love.graphics.setColor(255,0,0,255)
   love.graphics.rectangle('fill', 10, y, width, 10)
   love.graphics.setColor(r,g,b,a)
end