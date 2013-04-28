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
   local bulletA = nil
   local bulletB = nil
   local bulletAi = nil
   local bulletBi = nil
   local mobA = nil
   local mobB = nil
   local del = false

   -- Get the bullet
   for i, b in ipairs(globals.bullets) do
      if b.hitbox == hitbox_a or b.hitbox == hitbox_b then
         if not bulletA then
            bulletA = b
            bulletAi = i
         else
            bulletB = b
            bulletBi = i
         end
      end
   end

   -- Get the target
   if globals.player.hitbox == hitbox_a or globals.player.hitbox == hitbox_b then
      mobA = globals.player
   end

   for i, e in ipairs(globals.enemies) do
      if e.hitbox == hitbox_a or e.hitbox == hitbox_b then
         if not mobA then
            mobA = e
         else
            mobB = e
         end
      end
   end

   if bulletA and bulletB then
      if bullet_on_bullet(bulletA, bulletB) then
         bulletB:deinitialise()
         bulletA:deinitialise()
         table.remove(globals.bullets, bulletBi)
         table.remove(globals.bullets, bulletAi)
      end

   elseif mobA and mobB then
      if mobA == globals.player then
         player_on_enemy(mobB)
      else
         enemy_on_enemy(mobA, mobB)
      end

   elseif mobA and mobA == globals.player then
      if bullet_on_player(bulletA) then
         bulletA:deinitialise()
         table.remove(globals.bullets, bulletAi)
      end

   elseif mobA then
      if bullet_on_enemy(bulletA, mobA) then
         bulletA:deinitialise()
         table.remove(globals.bullets, bulletAi)
      end
   end
end


-- These functions can be overridden to change the behaviour of the
-- collision handling. If they return true, the bullets involved are deleted.
function bullet_on_bullet(bulletA, bulletB)
   if bulletA.bomb and bulletA.player ~= bulletB.player then
      bulletB:deinitialise()
      for i, b in ipairs(globals.bullets) do
         if b == bulletB then
            table.remove(globals.bullets, i)
            break
         end
      end

   elseif bulletB.bomb and bulletA.player ~= bulletB.player then
      bulletA:deinitialise()
      for i, b in ipairs(globals.bullets) do
         if b == bulletA then
            table.remove(globals.bullets, i)
            break
         end
      end
   end

   return false
end

function bullet_on_enemy(bullet, enemy)
   if not bullet.player then
      return false
   end

   bullet:collide(enemy)

   if bullet.player and enemy.dead then
      local exp = explosion.Explosion:create()
      exp:initialise(enemy.x, enemy.y, enemy.worth)
      table.insert(globals.explosions, exp)

      globals.player.score = globals.player.score + enemy.worth

      enemy:deinitialise()

      for i, e in ipairs(globals.enemies) do
         if e == enemy then
            table.remove(globals.enemies, i)
            break
         end
      end
   end

   return true
end

function bullet_on_player(bullet)
   if bullet.player then
      return false
   end

   bullet:collide(globals.player)
   return true
end

function player_on_enemy(enemy)
end

function enemy_on_enemy(enemyA, enemyB)
end
