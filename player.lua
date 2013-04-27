player = {
   -- Position
   x = 200,
   y = 150,

   -- Combat
   power = 100,

   -- Scoring
   score = 0,

   -- Health
   lives = 3,
   health = 100,
   maxhealth = 100,

   -- Sprite
   sprite = love.graphics.newImage("player.png"),
   width = 0,
   height = 0}

player.width = player.sprite:getWidth()
player.height = player.sprite:getHeight()

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
end

function player.draw()
   love.graphics.print("Score:  " .. player.score, 10, 10)
   love.graphics.print("Power:  " .. player.power, 10, 25)
   love.graphics.print("Lives:  " .. player.lives, 10, 40)
   love.graphics.print("Health: " .. player.health .. " / " .. player.maxhealth, 10, 55)

   love.graphics.draw(player.sprite, player.x, player.y, 0, 1, 1, player.width / 2, player.height / 2)
end
