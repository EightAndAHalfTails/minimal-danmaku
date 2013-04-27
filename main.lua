function love.load()
   -- Load game resources (music, images) from files, and set up initial state.
   paused = false
end

function love.update(dt)
   -- Update the game state. dt is the time delta. Don't do anything if paused.

   if paused then
      return
   end
end

function love.draw()
   -- Draw a frame
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
