module (..., package.seeall)

require "resources"
require "mob"

Player = {
   super   = mob.Mob,
   bombs   = nil,
   score   = nil,
   delay   = nil,
   bsprite = nil,
}

Player_mt = { __index = Player}
setmetatable(Player, mob.Mob_mt)

function Player:create(x, y)
   local new_inst = {}
   setmetatable(new_inst, Player_mt)

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

   local bullet = {
      -- Used in bullet.draw()
      sprite = self.bsprite,
      width = self.bsprite:getWidth(),
      height = self.bsprite:getHeight(),

      -- Used in bullet.draw() and bullet.checkcollide()
      x = self.x,
      y = self.y,
      hitbox = {
         width = self.bsprite:getWidth(),
         height = self.bsprite:getHeight()
      },

      -- Used in main.update
      player = true,
      step = nil,

      -- Used in bullet.collide()
      power = 0
   }

   bullet.step = function(dt) bullet.y = bullet.y - 500 * dt end

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
