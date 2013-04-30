module(..., package.seeall);

require "object"
require "entity"

Explosion = object.create({ text = nil,
			    ttl  = nil,
			    offset = nil},
			  entity.Entity )

function Explosion:initialise(x, y, text)
   self.super:initialise(x, y, resources.sprites["explosion.png"], 0, 0, 0)
   
   self.text = text
   self.ttl  = 1
   self.offset = 0
end

function Explosion:update(dt)
   -- TODO: do something to sprite
   self.offset = self.offset + 50 * dt
   self.ttl    = self.ttl - 1 * dt
end

function Explosion:draw()
   --draw explosion
   self.super:draw()

   if self.text then
      --draw points
      r, g, b, a = love.graphics.getColor()
      love.graphics.setColor(0, 0, 0, 255)
      love.graphics.printf(self.text, self.x - self.width/2, self.y - self.offset, self.width,"center")
      love.graphics.setColor(r, g, b, a)
   end
end