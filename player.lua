module (..., package.seeall)

require "object"
require "resources"
require "mob"
require "bullet"
require "math"
require "hud"
require "globals"

Player = object.create({bombs   = 3,
                        score   = 0,
                        delay   = 0, -- bullet cooldown
                        bsprite = nil,
                        speed = 400,
                        focus = false,
                        slowdown = 2.5
                       },
                       mob.Mob)

function Player:initialise(x, y)
   self.super:initialise(x, y, resources.sprites["player.png"], 24, 24, 100, 3, 100)

   self.bsprite = resources.sprites["bullet.png"]
end

function Player:update(dt)
   local x = self.x
   local y = self.y
   local speed = self.speed / (self.focus and self.slowdown or 1)

   if love.keyboard.isDown("right") then
      x = x + dt * speed
   elseif love.keyboard.isDown("left") then
      x = x - dt * speed
   end

   if love.keyboard.isDown("up") then
      y = y - dt * speed
   elseif love.keyboard.isDown("down") then
      y = y + dt * speed
   end

   -- Keep on screen
   x = math.max(0, x)
   x = math.min(globals.MAX_X, x)
   y = math.max(0, y)
   y = math.min(globals.MAX_Y, y)
   
   self:move(x, y)

   if self.delay > 0 then
      self.delay = self.delay - dt
      if self.delay < 0 then
         self.delay = 0
      end
   end

   if love.keyboard.isDown(globals.keymap.shoot) then
      if self.focus then
         self:focusfire()
      else
         self:emit()
      end
   end
end

function Player:draw()
   hud.draw()
   
   self.super.draw(self)

   if self.focus then
      x1, y1, x2, y2 = self.hitbox:bbox()
      
      r, g, b, a = love.graphics.getColor()
      love.graphics.setColor(50, 100, 150, 255)
      love.graphics.rectangle("line", x1, y1, x2 - x1, y2 - y1)
      love.graphics.setColor(r, g, b, a)
   end
end

function Player:emit()
   -- Emit a normal bullet
   if self.delay > 0 then
      return
   end

   local bullet = bullet.Bullet:create()
   bullet:initialise(self.x, self.y, self.bsprite, self.power, true, false, nil)
   bullet.step = function(self, dt) self:move(self.x, self.y - 500 * dt) end

   table.insert(globals.bullets, bullet)

   self.delay = 0.15
end

function Player:focusfire()
   -- Emit a focused bullet
   self:emit()
end

function Player:bomb()
   -- Emit a bomb, if we have any
   if self.bombs == 0 then
      return
   end

   for i = 1,2 do
      for j = 1,32 do
         local bullet = bullet.Bullet:create()
         bullet:initialise(self.x, self.y, self.bsprite, self.power * 10, true, true, nil)
         bullet.delay = (i - 1) * 0.2
         bullet.visible = false
         bullet.step = function(self, dt)
            if self.delay > 0 then
               self.delay = self.delay - dt
               self:move(globals.player.x, globals.player.y)
            end

            if self.delay <= 0 then
               self.visible = true

               local newx = 250 * dt
               local newy = -250 * dt
               local theta = 2 * math.pi * j / 32
               self:move(self.x + newx * math.cos(theta) - newy * math.sin(theta),
                         self.y + newx * math.sin(theta) + newy * math.cos(theta))
            end
         end

         table.insert(globals.bullets, bullet)
      end
   end

   -- Decrement bomb count
   self.bombs = self.bombs - 1
end
