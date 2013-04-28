module (..., package.seeall)

require "globals"

HC = require "HardonCollider"

function initialise()
   collider = HC(8, on_collision)
end

function update(dt)
   collider:update(dt)
end

function newHitbox(x, y, width, height)
   if width == 0 or height == 0 then
      return collider:addPoint(x, y)
   else
      return collider:addRectangle(
         x - width/2,
         y - height/2,
         width,
         height)
   end
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
   for i, b in ipairs(globals.bullets) do
      if b.hitbox == hitbox_a or b.hitbox == hitbox_b then
         bullet = b
         bullet_i = i
         break
      end
   end

   -- Get the target
   if globals.player.hitbox == hitbox_a or globals.player.hitbox == hitbox_b then
      target = globals.player
   else
      for i, e in ipairs(globals.enemies) do
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
   if target == globals.player and bullet.player then
      return
   end

   -- If the target is an enemy, and this is a bullet an enemy shot,
   -- ignore the collision.
   if target ~= globals.player and not bullet.player then
      return
   end

   -- Handle the actual collision
   bullet:collide(target)

   -- If we've just killed an enemy, display an explosion.
   if bullet.player and target.dead then
      local exp = explosion.Explosion:create()
      exp:initialise(target.x, target.y, target.worth)
      table.insert(globals.explosions, exp)

      globals.player.score = globals.player.score + target.worth

      target:deinitialise()
      table.remove(globals.enemies, target_i)
   end

   -- Delete the bullet
   bullet:deinitialise()
   table.remove(globals.bullets, bullet_i)
end
