module (..., package.seeall)

require "object"
require "resources"
require "mob"
require "bullet"
require "state"
require "math"
require "hud"
require "globals"

Player = object.create({bombs   = 3,
                        score   = 0,
                        delay   = 0, -- bullet cooldown
                        bsprite = nil},
                       mob.Mob)

function Player:initialise(x, y)
   self.super:initialise(x, y, resources.sprites["player.png"], 24, 24, 100, 3, 100)

   self.bsprite = resources.sprites["bullet.png"]
end

function Player:update(dt)
   local x = self.x
   local y = self.y

   if love.keyboard.isDown("right") then
      x = x + dt * 100 
   elseif love.keyboard.isDown("left") then
      x = x - dt * 100
   end

   if love.keyboard.isDown("up") then
      y = y - dt * 100
   elseif love.keyboard.isDown("down") then
      y = y + dt * 100
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
      self:emit()
   end
end

function Player:draw()
   hud.draw()
   
   self.super.draw(self)
end

function Player:emit()
   -- Emit a normal bullet
   if self.delay > 0 then
      return
   end

   local bullet = bullet.Bullet:create()
   bullet:initialise(self.x, self.y, self.bsprite, self.power, true, nil)
   bullet.step = function(self, dt) self:move(self.x, self.y - 500 * dt) end

   table.insert(state.bullets, bullet)

   self.delay = 0.15
end

function Player:bomb()
   -- Emit a bomb, if we have any
   if self.bombs == 0 then
      return
   end

   -- Destroy all enemy bullets
   -- TODO: update table in-place
   local new_bullets = {}
   for i, bullet in ipairs(state.bullets) do
      if bullet.player then
	 table.insert(new_bullets, bullet)
      end
   end
   state.bullets = new_bullets
   
   -- Damage enemies

   -- Decrement bomb count
   self.bombs = self.bombs - 1
end
