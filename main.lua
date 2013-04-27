paused  = false
bullets = {}

require "resources"
require "bullet"
require "player"

function love.load()
   -- Load resources
   resources.load()

   -- Set window size
   love.graphics.setMode(500, 900)

   -- Set up player
   theplayer = player.Player:create()
   theplayer:initialise(250, 850)

   -- Music!
   resources.sounds["gensou.ogg"]:setLooping(true)
   love.audio.play(resources.sounds["gensou.ogg"])
end

function love.update(dt)
   -- Update the game state. dt is the time delta. Don't do anything if paused.
   if paused then
      return
   end

   theplayer:update(dt)

   -- Move all bullets and check for collisions
   for idx, b in ipairs(bullets) do
      b:step(dt)

      if not b.player and b:checkCollide(player) then
         b:collide(player)
         table.remove(bullets, idx)
      elseif b:isOffscreen() then
         table.remove(bullets, idx)
      end
   end
end

function love.draw()
   -- Draw a frame
   love.graphics.draw(resources.backgrounds["background.png"], 0, 0)

   theplayer:draw()

   for idx, b in ipairs(bullets) do
      b:draw()
   end

   -- Paused text: drawn last so it's above everything else
   if paused then
      r, g, b, a = love.graphics.getColor()
      love.graphics.setColor(50, 100, 150)
      love.graphics.print("Paused", 200, 150, 0, 5, 5)
      love.graphics.setColor(r, g, b, a)
   end
end

function love.keypressed(key, unicode)
   -- Key pressed
   if paused then
      return
   end

   if key == 'x' then
      theplayer:bomb()
   end
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
