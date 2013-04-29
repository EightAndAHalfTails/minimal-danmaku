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

Rocket = object.create( { timer = 0,
			  delay = 3,
			  homing = true,
			  vx = 0, vy = 80,
			  ax = 0, ay = -40,
			  locked = false},
			Bullet)

function Rocket:initialise(x, y, delay, power, vx, ax)
   self.super:initialise(x, y,
			 resources.sprites["basicbullet.png"], --TODO: make rocket sprite
			 power,
			 false,
			 false,
			 nil)
   if vx then self.vx = vx end
   if ax then self.ax = ax end --sideways acceleration during ejection

   step = function(self, dt)
      self.timer = self.timer + dt

      if self.timer > self.delay and not self.locked then --lock on
	 --print("locking on")
	 local target_x = globals.player.x
	 local target_y = globals.player.y

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