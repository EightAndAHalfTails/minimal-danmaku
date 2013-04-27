require "player"

function love.load()
   -- Load game resources (music, images) from files, and set up initial state.
   paused = false
end

function love.update(dt)
   -- Update the game state. dt is the time delta. Don't do anything if paused.
   if paused then
      return
   end

   player.update(dt)
end

function love.draw()
   -- Draw a frame
   player.draw()

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
   if not paused then
      player.keypressed(key, unicode)
   end
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
