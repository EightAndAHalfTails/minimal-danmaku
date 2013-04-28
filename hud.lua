module(..., package.seeall)

require "globals"

function draw()
   r, g, b, a = love.graphics.getColor()
   love.graphics.setColor(0, 0, 0, 255)

   love.graphics.print("Score:  " .. globals.player.score, 10, 10)
   love.graphics.print("Power:  " .. globals.player.power, 10, 25)
   love.graphics.print("Bombs:  " .. globals.player.bombs, 10, 40)
   love.graphics.print("Lives:  " .. globals.player.lives, 10, 55)
   love.graphics.print("Health: " .. globals.player.health .. " / " .. globals.player.maxhealth, 10, 70)

   love.graphics.setColor(r, g, b, a)
end