module (..., package.seeall)

require "object"
require "mob"
require "resources"
require "bullet"
require "globals"

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

BasicEnemy = object.create( { vx = 0,
			      vy = 100,
			      ax = 0,
			      ay = 0,
			      delay = 1,
			      timer = 0 },
			    Enemy )

function BasicEnemy:initialise(x, y, vx, vy, ax, ay, delay, timer)
   self.super:initialise(x, y, resources.sprites["basicenemy.png"], 32, 32, 50, 10, 5)
   if vx then self.vx = vx end
   if vy then self.vy = vy end
   if ax then self.ax = ax end
   if ay then self.ay = ay end
   if delay then self.delay = delay end
   if timer then self.timer = timer end
end

function BasicEnemy:update(dt)
   self.super:update(dt)

   --move position
   local newx = self.x + self.vx * dt
   local newy = self.y + self.vy * dt
   self:move(newx, newy)

   --adjust velocity
   self.vx = self.vx + self.ax * dt
   self.vy = self.vy + self.ay * dt

   --what's this part for?
   if self.timer > 25 then
      self.vy = self.vy - 10 * dt
   end

   --check cooldown and fire
   if self.delay > 0 then
      self.delay = self.delay - dt
      if self.delay < 0 then
         self:emit()
      end
   end
end

function BasicEnemy:emit()
   local b1 = bullet.Bullet:create()
   local b2 = bullet.Bullet:create()
   local b3 = bullet.Bullet:create()

   b1:initialise(self.x, self.y, resources.sprites["basicbullet.png"], self.power, false, false, nil)
   b2:initialise(self.x, self.y, resources.sprites["basicbullet.png"], self.power, false, false, nil)
   b3:initialise(self.x, self.y, resources.sprites["basicbullet.png"], self.power, false, false, nil)

   b1.step = function(self, dt)
      self:move(self.x - 50 * dt, self.y + 200 * dt)
   end

   b2.step = function(self, dt)
      self:move(self.x, self.y + 200 * dt)
   end

   b3.step = function(self, dt)
      self:move(self.x + 50 * dt, self.y + 200 * dt)
   end

   table.insert(globals.bullets, b1)
   table.insert(globals.bullets, b2)
   table.insert(globals.bullets, b3)

   self.delay = 1
end