require "resources"
require "bullet"
require "player"
require "enemy"
require "globals"
require "explosion"
require "physics"
require "script"
require "stage1"

function love.load()
   -- Load resources
   resources.load()

   -- Set window size
   love.graphics.setMode(globals.MAX_X, globals.MAX_Y)

   -- Initialise physics
   physics.initialise()

   -- Set up player
   globals.player = player.Player:create()
   globals.player:initialise(globals.MAX_X/2, globals.MAX_Y-50)

   -- Music!
   resources.sounds["gensou.ogg"]:setLooping(true)
   love.audio.play(resources.sounds["gensou.ogg"])

   -- Load Script
   script.load(stage1.Script)

   -- Scatter around a few enemies
   --globals.enemies[0] = enemy.BasicEnemy:create()
   --globals.enemies[1] = enemy.BasicEnemy:create()
   --globals.enemies[2] = enemy.BasicEnemy:create()
   --globals.enemies[3] = enemy.BasicEnemy:create()

   --globals.enemies[0]:initialise(100, 100)
   --globals.enemies[1]:initialise(400, 100)
   --globals.enemies[2]:initialise(200, 200)
   --globals.enemies[3]:initialise(100, 500)
end

function love.update(dt)
   -- Update the game globals. dt is the time delta. Don't do anything if paused.
   if globals.paused then
      return
   end

   globals.player:update(dt)

   script.update(dt)

   -- Move all enemies
   for i, e in ipairs(globals.enemies) do
      e:update(dt)

      if e:isOffscreen() then
         e:deinitialise()
         table.remove(globals.enemies, i)
      end
   end

   -- Move all bullets
   for idx, b in ipairs(globals.bullets) do
      b:step(dt)

      if b:isOffscreen() then
         b:deinitialise()
         table.remove(globals.bullets, idx)
      end
   end

   -- Update physics
   physics.update(dt)

   --Update explosions
   for i, e in ipairs(globals.explosions) do
      e:update(dt)
   end
   --TODO: remove dead explosions in-place
   local new_exp = {}
   for i, exp in ipairs(globals.explosions) do
      --print(i, exp.ttl)
      if not (exp.ttl < 0) then
	 table.insert(new_exp, exp)
      end
   end
   globals.explosions = new_exp


end

function love.draw()
   -- Draw a frame
   love.graphics.draw(resources.backgrounds["background.png"], 0, 0)

   globals.player:draw()

   -- Draw bullets, enemies and explosions 
   for idx, b in ipairs(globals.bullets) do
      b:draw()
   end

   for idx, e in ipairs(globals.enemies) do
      e:draw()
   end

   for idx, e in ipairs(globals.explosions) do
      e:draw()
   end   

   -- Paused text: drawn last so it's above everything else
   if globals.paused then
      r, g, b, a = love.graphics.getColor()
      love.graphics.setColor(50, 100, 150)
      love.graphics.print("Paused", 200, 150, 0, 5, 5)
      love.graphics.setColor(r, g, b, a)
   end
end

function love.keypressed(key, unicode)
   -- Key pressed
   if key == globals.keymap.pause then
      globals.paused = not globals.paused
   end

   if globals.paused then
      return
   end

   if key == globals.keymap.bomb then
      globals.player:bomb()

   elseif key == globals.keymap.mute then
      if love.audio.getVolume() == 0 then
         love.audio.setVolume(1)
      else
         love.audio.setVolume(0)
      end

   elseif key == globals.keymap.focus then
      globals.player.focus = true
   end
end

function love.keyreleased(key, unicode)
   if globals.paused then
      return
   end

   if key == globals.keymap.focus then
      globals.player.focus = false
   end
end

function love.focus(f)
   -- Focus changed, 'f' is the focus globals.
   if not f then
      globals.paused = true
   end
end

function love.quit()
   -- Terminate game
end