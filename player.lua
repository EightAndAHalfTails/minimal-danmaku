module (..., package.seeall)

require "object"
require "resources"
require "mob"
require "bullet"
require "state"

Player = object.create({bombs   = 3,
                        score   = 0,
                        delay   = 0,
                        bsprite = nil},
                       mob.Mob)

function Player:initialise(x, y)
   self.super:initialise(x, y, resources.sprites["player.png"], 24, 24, 100, 3, 100)

   self.bsprite = resources.sprites["bullet.png"]
end

function Player:update(dt)
   if love.keyboard.isDown("right") then
      self.x = self.x + dt * 100
   elseif love.keyboard.isDown("left") then
      self.x = self.x - dt * 100
   end

   if love.keyboard.isDown("up") then
      self.y = self.y - dt * 100
   elseif love.keyboard.isDown("down") then
      self.y = self.y + dt * 100
   end

   if self.delay > 0 then
      self.delay = self.delay - dt
      if self.delay < 0 then
         self.delay = 0
      end
   end

   if love.keyboard.isDown(globals.keymap.shoot) then
      self:emit()
   end
end

function Player:draw()
   r, g, b, a = love.graphics.getColor()
   love.graphics.setColor(0, 0, 0, 255)

   love.graphics.print("Score:  " .. self.score, 10, 10)
   love.graphics.print("Power:  " .. self.power, 10, 25)
   love.graphics.print("Bombs:  " .. self.bombs, 10, 40)
   love.graphics.print("Lives:  " .. self.lives, 10, 55)
   love.graphics.print("Health: " .. self.health .. " / " .. self.maxhealth, 10, 70)

   love.graphics.setColor(r, g, b, a)

   self.super.draw(self)
end

function Player:emit()
   -- Emit a normal bullet
   if self.delay > 0 then
      return
   end

   local bullet = bullet.Bullet:create()
   bullet:initialise(self.x, self.y, self.bsprite, self.power, true, nil)
   bullet.step = function(self, dt) self.y = self.y - 500 * dt end

   table.insert(state.bullets, bullet)

   self.delay = 0.15
end

function Player:bomb()
   -- Emit a bomb, if we have any
   if self.bombs == 0 then
      return
   end

   self.bombs = self.bombs - 1
end
