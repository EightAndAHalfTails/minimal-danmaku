module(..., package.seeall);

require "enemy"
require "globals"

local time = 0.0

-- Timings are in deciseconds
Script = {
   [4] = { { enemy = "basic", x = 100, y = 0 },
	   { enemy = "basic", x = 400, y = 0 }, done = false },
   [8] = { { enemy = "basic", x = 200, y = 0 },
	   { enemy = "basic", x = 300, y = 0 }, done = false },
   [40] = { { enemy = "basic", x = 250, y = 0}, done = false }
}

function update(dt)
   time = time + dt*10

   for t, list in pairs(Script) do
      if t < time then
	 if not list.done then
	    for i, e in ipairs(list) do
	       execute(e)
	    list.done = true
	    end
	 end
      end
   end
end

function execute(entry)
   if entry.enemy == "basic" then
      new_enemy = enemy.BasicEnemy:create()
      new_enemy:initialise(entry.x, entry.y)
      table.insert(globals.enemies, new_enemy)
   end
end