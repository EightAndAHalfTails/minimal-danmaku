module(..., package.seeall);

require "enemy"
require "globals"

-- Timings are in deciseconds
Script = {
   [4] = { { enemyType = enemy.BasicEnemy, x = 100, y = 0 },
	   { enemyType = enemy.BasicEnemy, x = 400, y = 0 }, done = false },
   [8] = { { enemyType = enemy.BasicEnemy, x = 200, y = 0 },
	   { enemyType = enemy.BasicEnemy, x = 300, y = 0 }, done = false },
   [40] = { { enemyType = enemy.BasicEnemy, x = 250, y = 0}, done = false }
}

