require "state"
require "resources"
require "bullet"
require "player"
require "enemy"

function love.load()
   -- Load resources
   resources.load()

   -- Set window size
   love.graphics.setMode(500, 900)

   -- Set up player
   state.player = player.Player:create()
   state.player:initialise(250, 850)

   -- Music!
   resources.sounds["gensou.ogg"]:setLooping(true)
   love.audio.play(resources.sounds["gensou.ogg"])

   -- Scatter around a few enemies
   state.enemies[0] = enemy.BasicEnemy:create()
   state.enemies[1] = enemy.BasicEnemy:create()
   state.enemies[2] = enemy.BasicEnemy:create()
   state.enemies[3] = enemy.BasicEnemy:create()

   state.enemies[0]:initialise(100, 100)
   state.enemies[1]:initialise(400, 100)
   state.enemies[2]:initialise(200, 200)
   state.enemies[3]:initialise(100, 500)
end

function love.update(dt)
   -- Update the game state. dt is the time delta. Don't do anything if paused.
   if state.paused then
      return
   end

   state.player:update(dt)

   -- Move all enemies
   for i, e in ipairs(state.enemies) do
      e:update(dt)

      if e:isOffscreen() then
         table.remove(state.enemies, i)
      end
   end

   -- Move all bullets and check for collisions
   for idx, b in ipairs(state.bullets) do
      b:step(dt)

      if not b.player and b:checkCollide(state.player) then
         b:collide(state.player)
         table.remove(state.bullets, idx)

      elseif b.player then
         for i, e in ipairs(state.enemies) do
            if b:checkCollide(e) then
               b:collide(e)
               if e.dead then
                  state.player.score = state.player.score + e.worth
                  table.remove(state.bullets, idx)
                  table.remove(state.enemies, i)
               end
            end
         end

      elseif b:isOffscreen() then
         table.remove(state.bullets, idx)
      end
   end
end

function love.draw()
   -- Draw a frame
   love.graphics.draw(resources.backgrounds["background.png"], 0, 0)

   state.player:draw()

   -- Draw bullets and enemies
   for idx, b in ipairs(state.bullets) do
      b:draw()
   end

   for idx, e in ipairs(state.enemies) do
      e:draw()
   end

   -- Paused text: drawn last so it's above everything else
   if state.paused then
      r, g, b, a = love.graphics.getColor()
      love.graphics.setColor(50, 100, 150)
      love.graphics.print("Paused", 200, 150, 0, 5, 5)
      love.graphics.setColor(r, g, b, a)
   end
end

function love.keypressed(key, unicode)
   -- Key pressed
   if key == 'escape' then
      state.paused = not state.paused
   end

   if state.paused then
      return
   end

   if key == 'x' then
      state.player:bomb()
   end
end

function love.focus(f)
   -- Focus changed, 'f' is the focus state.
   if not f then
      state.paused = true
   end
end

function love.quit()
   -- Terminate game
end
