module(..., package.seeall)

require "state"
require "player"

function draw()
   r, g, b, a = love.graphics.getColor()
   love.graphics.setColor(0, 0, 0, 255)

   love.graphics.print("Score:  " .. state.player.score, 10, 10)
   love.graphics.print("Power:  " .. state.player.power, 10, 25)
   love.graphics.print("Bombs:  " .. state.player.bombs, 10, 40)
   love.graphics.print("Lives:  " .. state.player.lives, 10, 55)
   love.graphics.print("Health: " .. state.player.health .. " / " .. state.player.maxhealth, 10, 70)

   love.graphics.setColor(r, g, b, a)
end