module(..., package.seeall);

require "object"
require "entity"
require "bullet"

Rocket = object.create( { timer = 0,
			  delay = 3,
			  vx = 0, vy = 80,
			  ax = 0, ay = -40,
			  locked = false},
			bullet.Bullet)

function Rocket:initialise(x, y, vx, vy, ax, ay, delay, power)
   self.super:initialise(x, y,
			 resources.sprites["basicbullet.png"], --TODO: make rocket sprite
			 power,
			 false,
			 false,
			 nil)

   if vx then self.vx = vx end
   if vy then self.vy = vy end
   if ax then self.ax = ax end --sideways acceleration during ejection
   if ay then self.ay = ay end
   if delay then self.delay = delay end

   self.fudge = 50 --pixels of error in locking on

   step = function(self, dt)
      self.timer = self.timer + dt

      if self.timer > self.delay and not self.locked then --lock on
	 --print("locking on")
	 local x_err = math.random(-self.fudge, self.fudge)
	 local y_err = math.random(-self.fudge, self.fudge)

	 local target_x = globals.player.x + x_err
	 local target_y = globals.player.y + y_err

	 self.vx = target_x - self.x
	 self.vy = target_y - self.y

	 self.ax = 0
	 self.ay = 0
	 
	 --TODO: work out how to rotate sprite
	 --self.sprite = self.sprite:rotate(math.atan2(self.vx, self.vy))

	 self.locked = true
      end

      local newx = self.x + self.vx * dt
      local newy = self.y + self.vy * dt
      self:move(newx, newy)
      
      self.vx = self.vx + self.ax * dt
      self.vy = self.vy + self.ay * dt
   end

   self.step = step
end