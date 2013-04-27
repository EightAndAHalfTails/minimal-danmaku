module(..., package.seeall);

function draw(bullet)
   love.graphics.draw(bullet.sprite, bullet.x, bullet.y, 0, 1, 1, bullet.width / 2, bullet.height / 2)
end
   
function checkcollide(bullet, target)
   return not ((bullet.x - bullet.hitbox.width/2) > (target.x + target.hitbox.width/2) or
               (bullet.x + bullet.hitbox.width/2) < (target.x - target.hitbox.width/2) or
               (bullet.y - bullet.hitbox.height/2) < (target.y + target.hitbox.height/2) or
               (bullet.y + bullet.hitbox.height/2) > (target.y - target.hitbox.height/2))
end

function collide(bullet, target)
   target.damage(bullet.power)
end

function offscreen(bullet)
   return bullet.y < 0
end
