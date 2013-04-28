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
   self.offset = self.offset + 10 * dt
   self.ttl    = self.ttl - 1 * dt
end

function Explosion:draw()
   self.super:draw()
end