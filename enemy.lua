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
   --if self.timer > 25 then
   --   self.vy = self.vy - 10 * dt
   --end

   --check cooldown and fire
   if self.delay > 0 then
      self.delay = self.delay - dt
   else
      self:emit()
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

-- First Boss
Boss1 = object.create( { vx = 0,
			 vy = 10,
			 rocket_delay = 3,
			 shot_delay = 1,
			 firing = false },
		       Enemy )

function Boss1:initialise()
   self.super:initialise(
      globals.MAX_X/2,
      0,
      resources.sprites["basicenemy.png"],
      32, 32, --hitbox dimensions
      101, --power
      5000, --health
      9001 --worth
			)
end

function Boss1:update(dt)
   self.super:update(dt) --increase timer
   --print(self.x, self.y, self.timer, self.firing)

   --move position
   if self.y < 64 then
      local newy = self.y + self.vy * dt
      self:move(self.x, newy)
   end
      
   if self.timer > 5 then
      self.firing = true
   end

   --check cooldown and fire
   if self.firing then
      if self.rocket_delay > 0 then
	 self.rocket_delay = self.rocket_delay - dt
      else
	 self:emit()
	 self.rocket_delay = 3
      end
      
      if self.shot_delay > 0 then
	 self.shot_delay = self.shot_delay - dt
      else
	 BasicEnemy.emit(self)
	 self.shot_delay = 1
      end
   end
end

function Boss1:emit()
   
   local b1 = bullet.Rocket:create()
   local b2 = bullet.Rocket:create()

   b1:initialise(self.x, self.y, 3, 101, -10, -20)
   b2:initialise(self.x, self.y, 3, 101, 10, 20)

   table.insert(globals.bullets, b1)
   table.insert(globals.bullets, b2)
end

