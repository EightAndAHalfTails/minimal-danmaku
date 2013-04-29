module(..., package.seeall);

require "enemy"
require "globals"
require "resources"

music = "gensou.ogg"
background = "background.png"

-- Timings are in deciseconds
script   = {
   [4]   = { { enemyType = enemy.BasicEnemy, x = 100, y = 0 },
	     { enemyType = enemy.BasicEnemy, x = 400, y = 0 }, done = false },
   [8]   = { { enemyType = enemy.BasicEnemy, x = 200, y = 0 },
	     { enemyType = enemy.BasicEnemy, x = 300, y = 0 }, done = false },
   [40]  = { { enemyType = enemy.BasicEnemy, x = 0, y = 100, vx = 200, vy = 0}, done = false },
   [45]  = { { enemyType = enemy.BasicEnemy, x = 0, y = 100, vx = 200, vy = 0}, done = false },
   [50]  = { { enemyType = enemy.BasicEnemy, x = 0, y = 100, vx = 200, vy = 0}, done = false },
   [55]  = { { enemyType = enemy.BasicEnemy, x = 0, y = 100, vx = 200, vy = 0}, done = false },
   [100] = { { enemyType = enemy.BasicEnemy, x = globals.MAX_X, y = 200, vx = -200, vy = 0, ay = 30}, done = false},
   [105] = { { enemyType = enemy.BasicEnemy, x = globals.MAX_X, y = 200, vx = -200, vy = 0, ay = 30}, done = false},
   [110] = { { enemyType = enemy.BasicEnemy, x = globals.MAX_X, y = 200, vx = -200, vy = 0, ay = 30}, done = false},
   [115] = { { enemyType = enemy.BasicEnemy, x = globals.MAX_X, y = 200, vx = -200, vy = 0, ay = 30}, done = false}
}