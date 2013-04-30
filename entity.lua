module(..., package.seeall);

require "object"
require "physics"

Entity = object.create()

Entity.x       = nil
Entity.y       = nil
Entity.sprite  = nil
Entity.width   = nil
Entity.height  = nil
Entity.hitbox  = nil
Entity.power   = nil
Entity.visible = true

function Entity:initialise(x, y, sprite, hwidth, hheight, power)
    self.x      = x
    self.y      = y
    self.sprite = sprite
    self.width  = sprite:getWidth()
    self.height = sprite:getHeight()
    self.power  = power

    self.hitbox = physics.newHitbox(x, y, hwidth, hheight)
end

function Entity:deinitialise()
   physics.delHitbox(self.hitbox)
end

function Entity:update(dt)
   error("update unimplemented")
end

function Entity:move(x, y)
   self.x = x
   self.y = y
   self.hitbox:moveTo(x, y)
end

function Entity:draw()
   if self.visible then
      love.graphics.draw(self.sprite, self.x, self.y, 0, 1, 1,
                         self.width / 2, self.height / 2)
   end
end

function Entity:isOffscreen()
   return not ( self.x > 0 and
		self.x < globals.MAX_X and
		self.y > 0 and
		self.y < globals.MAX_Y )
end
