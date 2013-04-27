module (..., package.seeall)

require "resources"
require "mob"
require "bullet"

Player = {}

function Player:create(x, y)
   -- Create the new instance
   local new_inst = {super   = mob.Mob:create(),
                     bombs   = nil,
                     score   = nil,
                     delay   = nil,
                     bsprite = nil}

   -- Set the metatable to the superclass, for inheritance
   setmetatable(new_inst, { __index = new_inst.super })

   -- Copy in references to the class methods
   for k, v in pairs(Player) do
      new_inst[k] = v
   end

   return new_inst
end

function Player:initialise(x, y)
   self.super:initialise(x, y, resources.sprites["player.png"], 16, 16, 100, 3, 100)

   self.bombs   = 0
   self.score   = 0
   self.delay   = 0
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

   if love.keyboard.isDown("z") then
      self:emit()
   end
end

function Player:draw()
   love.graphics.print("Score:  " .. self.score, 10, 10)
   love.graphics.print("Power:  " .. self.power, 10, 25)
   love.graphics.print("Bombs:  " .. self.bombs, 10, 40)
   love.graphics.print("Lives:  " .. self.lives, 10, 55)
   love.graphics.print("Health: " .. self.health .. " / " .. self.maxhealth, 10, 70)

   self.super.draw(self)
end

function Player:keypressed(key, unicode)
   if key == 'x' then
      self:bomb()
   end
end

function Player:emit()
   -- Emit a normal bullet
   if self.delay > 0 then
      return
   end

   local bullet = bullet.Bullet:create()
   bullet:initialise(self.x, self.y, self.bsprite, self.power, true, nil)
   bullet.step = function(self, dt) self.y = self.y - 500 * dt end

   table.insert(bullets, bullet)

   self.delay = 0.15
end

function Player:bomb()
   -- Emit a bomb, if we have any
   if self.bombs == 0 then
      return
   end

   self.bombs = self.bombs - 1
end
