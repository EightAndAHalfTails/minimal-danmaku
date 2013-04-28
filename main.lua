require "state"
require "resources"
require "bullet"
require "player"
require "enemy"
require "globals"
require "explosion"
HC = require "HardonCollider"

function love.load()
   -- Load resources
   resources.load()

   -- Set window size
   love.graphics.setMode(globals.MAX_X, globals.MAX_Y)

   -- Initialise collision handling
   globals.collider = HC(8, collision)

   -- Set up player
   state.player = player.Player:create()
   state.player:initialise(globals.MAX_X/2, globals.MAX_Y-50)

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

function collision(dt, hitbox_a, hitbox_b, mtv_x, mtv_y)
   local bullet = nil
   local bullet_i = nil
   local target = nil
   local target_i = nil;

   -- Get the bullet
   for i, b in ipairs(state.bullets) do
      if b.hitbox == hitbox_a or b.hitbox == hitbox_b then
         bullet = b
         bullet_i = i
         break
      end
   end

   -- Get the target
   if state.player.hitbox == hitbox_a or state.player.hitbox == hitbox_b then
      target = state.player
   else
      for i, e in ipairs(state.enemies) do
         if e.hitbox == hitbox_a or e.hitbox == hitbox_b then
            target = e
            target_i = i
            break
         end
      end
   end

   -- If we have a bullet but no target, this is a bullet-on-bullet
   -- collision; if we have a target but no bullet, this is an
   -- enemy-on-enemy or enemy-on-player collision. Both cases should
   -- be ignored.
   if bullet == nil or target == nil then
      return
   end

   -- If the target is the player, and this is a bullet the player
   -- shot, ignore the collision.
   if target == state.player and bullet.player then
      return
   end

   -- If the target is an enemy, and this is a bullet an enemy shot,
   -- ignore the collision.
   if target ~= state.player and not bullet.player then
      return
   end

   -- Handle the actual collision
   bullet:collide(target)

   -- If we've just killed an enemy, display an explosion.
   if bullet.player and target.dead then
      local exp = explosion.Explosion:create()
      exp:initialise(target.x, target.y, target.worth)
      table.insert(state.explosions, exp)

      state.player.score = state.player.score + target.worth
      table.remove(state.enemies, target_i)
   end

   -- Delete the bullet
   table.remove(state.bullets, bullet_i)
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

      if b:isOffscreen() then
         table.remove(state.bullets, idx)
      end
   end

   globals.collider:update(dt)

   --Update explosions
   for i, e in ipairs(state.explosions) do
      e:update(dt)
   end
   --TODO: remove dead explosions in-place
   local new_exp = {}
   for i, exp in ipairs(state.explosions) do
      --print(i, exp.ttl)
      if not (exp.ttl < 0) then
	 table.insert(new_exp, exp)
      end
   end
   state.explosions = new_exp


end

function love.draw()
   -- Draw a frame
   love.graphics.draw(resources.backgrounds["background.png"], 0, 0)

   state.player:draw()

   -- Draw bullets, enemies and explosions 
   for idx, b in ipairs(state.bullets) do
      b:draw()
   end

   for idx, e in ipairs(state.enemies) do
      e:draw()
   end

   for idx, e in ipairs(state.explosions) do
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
   if key == globals.keymap.pause then
      state.paused = not state.paused
   end

   if state.paused then
      return
   end

   if key == globals.keymap.bomb then
      state.player:bomb()
   end

   if key == globals.keymap.mute then
      if love.audio.getVolume() == 0 then
	 love.audio.setVolume(1)
      else
	 love.audio.setVolume(0)
      end
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