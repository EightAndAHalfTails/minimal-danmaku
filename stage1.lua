module(..., package.seeall);

require "enemy"
require "globals"

local time = 0.0

-- Timings are in deciseconds
Script = {
   [4] = { enemy = "basic", x = 100, y = 0, done = false },
   [8] = { enemy = "basic", x = 200, y = 0, done = false },
   [12] = { enemy = "basic", x = 300, y = 0, done = false },
   [16] = { enemy = "basic", x = 400, y = 0, done = false }
}

function update(dt)
   time = time + dt*10

   for i, e in pairs(Script) do
      --print(i, e)
      if i < time then
	 if not e.done then
	    execute(e)
	    e.done = true
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