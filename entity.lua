module(..., package.seeall);

require "object"

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
    self.hitbox = {width = hwidth, height = hheight}
    self.power  = power
end

function Entity:update()
   error("update unimplemented")
end

function Entity:draw()
   love.graphics.draw(self.sprite, self.x, self.y, 0, 1, 1,
                      self.width / 2, self.height / 2)
end

function Entity:checkCollide(target)
   local sleft   = self.x - self.hitbox.width/2
   local sright  = self.x + self.hitbox.width/2
   local stop    = self.y - self.hitbox.height/2
   local sbottom = self.y + self.hitbox.height/2

   local tleft   = target.x - target.hitbox.width/2
   local tright  = target.x + target.hitbox.width/2
   local ttop    = target.y - target.hitbox.height/2
   local tbottom = target.y + target.hitbox.height/2

   return not (sleft > tright or
               sright < tleft or
               stop < ttop or
               sbottom > tbottom)
end

function Entity:isOffscreen()
   -- TODO: off the sides or bottom
   return self.y < 0
end
