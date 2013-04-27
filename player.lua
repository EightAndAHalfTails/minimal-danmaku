player = {
   -- Position
   x = 200,
   y = 150,

   -- Combat
   power = 100,
   bombs = 3,

   -- Scoring
   score = 0,

   -- Health
   lives = 3,
   health = 100,
   maxhealth = 100,
   dead = false,

   -- Sprite
   sprite = nil,
   width = 0,
   height = 0,

   -- Misc
   delay = 0}

function player.load()
   player.sprite = love.graphics.newImage("player.png")
   player.width  = player.sprite:getWidth()
   player.height = player.sprite:getHeight()

   player.bulletSprite = love.graphics.newImage("bullet.png")
   player.bulletSpriteWidth = player.bulletSprite:getWidth()
   player.bulletSpriteHeight = player.bulletSprite:getHeight()
end

function player.update(dt)
   if love.keyboard.isDown("right") then
      player.x = player.x + dt * 100
   elseif love.keyboard.isDown("left") then
      player.x = player.x - dt * 100
   end

   if love.keyboard.isDown("up") then
      player.y = player.y - dt * 100
   elseif love.keyboard.isDown("down") then
      player.y = player.y + dt * 100
   end

   if player.delay > 0 then
      player.delay = player.delay - dt
      if player.delay < 0 then
         player.delay = 0
      end
   end

   if love.keyboard.isDown("z") then
      player.emit(dt)
   end
end

function player.draw()
   love.graphics.print("Score:  " .. player.score, 10, 10)
   love.graphics.print("Power:  " .. player.power, 10, 25)
   love.graphics.print("Bombs:  " .. player.bombs, 10, 40)
   love.graphics.print("Lives:  " .. player.lives, 10, 55)
   love.graphics.print("Health: " .. player.health .. " / " .. player.maxhealth, 10, 70)

   love.graphics.draw(player.sprite, player.x, player.y, 0, 1, 1, player.width / 2, player.height / 2)
end

function player.keypressed(key, unicode)
   if key == 'x' then
      player.bomb()
   end
end

function player.emit(dt)
   -- Emit a normal bullet
   if player.delay > 0 then
      return
   end

   local bullet = {
      -- Used in bullet.draw()
      sprite = player.bulletSprite,
      width = player.bulletSpriteWidth,
      height = player.bulletSpriteHeight,

      -- Used in bullet.draw() and bullet.checkcollide()
      x = player.x,
      y = player.y,
      hitbox = {
         width = player.bulletSpriteWidth,
         height = player.bulletSpriteHeight
      },

      -- Used in main.update
      player = true,
      step = nil,

      -- Used in bullet.collide()
      power = 0
   }

   bullet.step = function(dt) bullet.y = bullet.y - 500 * dt end

   table.insert(bullets, bullet)

   player.delay = 0.15
end

function player.bomb()
   -- Emit a bomb, if we have any
   if player.bombs == 0 then
      return
   end

   player.bombs = player.bombs - 1
end

function player.damage(damage)
   -- Decrease health, and lives if necessary
   player.health = player.health - damage

   if player.health < 0 then
      player.health = player.maxhealth
      player.lives = player.lives - 1

      player.dead = player.lives >= 0
   end
end