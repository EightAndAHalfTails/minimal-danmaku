module(..., package.seeall);

require "enemy"
require "globals"

local time = 0.0

-- Timings are in deciseconds
Script = {
   [4] = { { enemyType = enemy.BasicEnemy, x = 100, y = 0 },
	   { enemyType = enemy.BasicEnemy, x = 400, y = 0 }, done = false },
   [8] = { { enemyType = enemy.BasicEnemy, x = 200, y = 0 },
	   { enemyType = enemy.BasicEnemy, x = 300, y = 0 }, done = false },
   [40] = { { enemyType = enemy.BasicEnemy, x = 250, y = 0}, done = false }
}

function update(dt)
   time = time + dt*10

   for t, list in pairs(Script) do
      if t < time then
	 if not list.done then
	    for i, e in ipairs(list) do
	       print(e.enemyType)
	       execute(e)
	    list.done = true
	    end
	 end
      end
   end
end

function execute(entry)
   if entry.enemyType then
      new_enemy = entry.enemyType:create()
      new_enemy:initialise(entry.x, entry.y)
      table.insert(globals.enemies, new_enemy)
   end
end