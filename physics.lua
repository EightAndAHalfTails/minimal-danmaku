module (..., package.seeall)

require "state"

HC = require "HardonCollider"

function initialise()
   collider = HC(8, on_collision)
end

function update(dt)
   collider:update(dt)
end

function newHitbox(x, y, width, height)
   return collider:addRectangle(
          x - width/2,
          y - height/2,
          width,
          height)
end

function delHitbox(shape)
   collider:remove(shape)
end

function on_collision(dt, hitbox_a, hitbox_b, mtv_x, mtv_y)
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

      target:deinitialise()
      table.remove(state.enemies, target_i)
   end

   -- Delete the bullet
   bullet:deinitialise()
   table.remove(state.bullets, bullet_i)
end
