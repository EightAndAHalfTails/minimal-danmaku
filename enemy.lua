module (..., package.seeall)

require "object"
require "mob"
require "resources"
require "bullet"

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

BasicEnemy = object.create({vy = 100,
                            delay = 1,
                            timer = 0},
                           Enemy)

function BasicEnemy:initialise(x, y)
   self.super:initialise(x, y, resources.sprites["basicenemy.png"], 32, 32, 50, 10, 5)
end

function BasicEnemy:update(dt)
   self.super:update(dt)

   self.y = self.y + self.vy * dt

   if self.timer > 25 then
      self.vy = self.vy - 10 * dt
   end

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

   b1:initialise(self.x, self.y, resources.sprites["basicbullet.png"], self.power, false, nil)
   b2:initialise(self.x, self.y, resources.sprites["basicbullet.png"], self.power, false, nil)
   b3:initialise(self.x, self.y, resources.sprites["basicbullet.png"], self.power, false, nil)

   b1.step = function(self, dt)
      self.x = self.x - 50 * dt
      self.y = self.y + 100 * dt
   end

   b2.step = function(self, dt)
      self.y = self.y + 100 * dt
   end

   b3.step = function(self, dt)
      self.x = self.x + 50 * dt
      self.y = self.y + 100 * dt
   end

   table.insert(bullets, b1)
   table.insert(bullets, b2)
   table.insert(bullets, b3)

   self.delay = 1
end
