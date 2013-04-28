module(..., package.seeall);

require "object"
require "physics"

Entity = object.create({x      = nil,
                        y      = nil,
                        sprite = nil,
                        width  = nil,
                        height = nil,
                        hitbox = nil,
                        power  = nil})

function Entity:initialise(x, y, sprite, hwidth, hheight, power)
    self.x      = x
    self.y      = y
    self.sprite = sprite
    self.width  = sprite:getWidth()
    self.height = sprite:getHeight()
    self.power  = power

    if hwidth > 0 and hheight > 0 then
       self.hitbox = physics.newHitbox(x, y, hwidth, hheight)
    end
end

function Entity:update(dt)
   error("update unimplemented")
end

function Entity:move(x, y)
   self.x = x
   self.y = y

   if self.hitbox then
      self.hitbox:moveTo(x, y)
   end
end

function Entity:draw()
   love.graphics.draw(self.sprite, self.x, self.y, 0, 1, 1,
                      self.width / 2, self.height / 2)
end

function Entity:isOffscreen()
   return not ( self.x > 0 and
		self.x < globals.MAX_X and
		self.y > 0 and
		self.y < globals.MAX_Y )
end
