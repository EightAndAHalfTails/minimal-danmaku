function love.load()
   -- Load game resources (music, images) from files, and set up initial state.
   paused = false

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
      sprite = love.graphics.newImage("Ship.png"),
      width = 0,
      height = 0}

   player.width = player.sprite:getWidth()
   player.height = player.sprite:getHeight()
end

function love.update(dt)
   -- Update the game state. dt is the time delta. Don't do anything if paused.
   if paused then
      return
   end

   -- Position
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

function love.draw()
   -- Draw a frame

   -- Player state
   love.graphics.print("Score:  " .. player.score, 10, 10)
   love.graphics.print("Power:  " .. player.power, 10, 25)
   love.graphics.print("Lives:  " .. player.lives, 10, 40)
   love.graphics.print("Health: " .. player.health .. " / " .. player.maxhealth, 10, 55)

   love.graphics.draw(player.sprite, player.x, player.y, 0, 1, 1, player.width / 2, player.height / 2)

   -- Paused text: drawn last so it's above everything else
   if paused then
      r, g, b, a = love.graphics.getColor()
      love.graphics.setColor(50, 100, 150)
      love.graphics.print("Paused", 200, 150, 0, 5, 5)
      love.graphics.setColor(r, g, b, a)
   end
end

function love.mousepressed(x, y, button)
   -- Mouse pressed
end

function love.mousereleased(x, y, button)
   -- Mouse released
end

function love.keypressed(key, unicode)
   -- Key pressed
end

function love.keyreleased(key, unicode)
   -- Key released
end

function love.focus(f)
   -- Focus changed, 'f' is the focus state.
   if not f then
      paused = true
   end
end

function love.quit()
   -- Terminate game
end
