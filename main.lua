function love.load()
   -- Load game resources (music, images) from files, and set up initial state.
   paused = false

   player = { x = 200, -- Position
              y = 150,
              sprite = love.graphics.newImage("player.png"), -- Sprite
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
   if paused then
      love.graphics.print("Paused", 0, 0)
   end

   love.graphics.draw(player.sprite, player.x, player.y, 0, 1, 1, player.width / 2, player.height / 2)
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
