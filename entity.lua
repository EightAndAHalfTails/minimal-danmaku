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
   print(self.hitbox)
   print(target.hitbox)
   return not ((self.x - self.hitbox.width/2) > (target.x + target.hitbox.width/2) or
               (self.x + self.hitbox.width/2) < (target.x - target.hitbox.width/2) or
               (self.y - self.hitbox.height/2) < (target.y + target.hitbox.height/2) or
               (self.y + self.hitbox.height/2) > (target.y - target.hitbox.height/2))
end

function Entity:isOffscreen()
   -- TODO: off the sides or bottom
   return self.y < 0
end
