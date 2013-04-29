module(..., package.seeall);

require "enemy"
require "globals"
require "resources"

music = "gensou.ogg"
background = "background.png"

-- Timings are in deciseconds
script   = {
   [5]   = { { enemyType = enemy.BasicEnemy, x = 100, y = 0, vy = 500, ay = -200 },
	     { enemyType = enemy.BasicEnemy, x = 400, y = 0, vy = 500, ay = -200 }, done = false },
   [10]  = { { enemyType = enemy.BasicEnemy, x = 200, y = 0, vy = 500, ay = -200 },
	     { enemyType = enemy.BasicEnemy, x = 300, y = 0, vy = 500, ay = -200 }, done = false },
   [40]  = { { enemyType = enemy.BasicEnemy, x = 0, y = 100, vx = 200, vy = 0 }, done = false },
   [45]  = { { enemyType = enemy.BasicEnemy, x = 0, y = 100, vx = 200, vy = 0 }, done = false },
   [50]  = { { enemyType = enemy.BasicEnemy, x = 0, y = 100, vx = 200, vy = 0 }, done = false },
   [55]  = { { enemyType = enemy.BasicEnemy, x = 0, y = 100, vx = 200, vy = 0 }, done = false },
   [100] = { { enemyType = enemy.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},
   [105] = { { enemyType = enemy.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},
   [110] = { { enemyType = enemy.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},
   [115] = { { enemyType = enemy.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},
   [120] = { { enemyType = enemy.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},
   [125] = { { enemyType = enemy.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},
   [130] = { { enemyType = enemy.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},
   [135] = { { enemyType = enemy.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},
   [140] = { { enemyType = enemy.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},
   [145] = { { enemyType = enemy.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},
   [150] = { { enemyType = enemy.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},
   [155] = { { enemyType = enemy.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},

   [200] = { { enemyType = enemy.BasicEnemy, x = 0, y = 100, vx = 300, vy = 300},
	     { enemyType = enemy.BasicEnemy, x = globals.MAX_X, y = 100, vx = -300, vy = 300}, done = false },
   [210] = { { enemyType = enemy.BasicEnemy, x = 0, y = 100, vx = 300, vy = 300},
	     { enemyType = enemy.BasicEnemy, x = globals.MAX_X, y = 100, vx = -300, vy = 300}, done = false },
   [220] = { { enemyType = enemy.BasicEnemy, x = 0, y = 100, vx = 300, vy = 300},
	     { enemyType = enemy.BasicEnemy, x = globals.MAX_X, y = 100, vx = -300, vy = 300}, done = false },
   [230] = { { enemyType = enemy.BasicEnemy, x = 0, y = 100, vx = 300, vy = 300},
	     { enemyType = enemy.BasicEnemy, x = globals.MAX_X, y = 100, vx = -300, vy = 300}, done = false },
   [240] = { { enemyType = enemy.BasicEnemy, x = 0, y = 100, vx = 300, vy = 300},
	     { enemyType = enemy.BasicEnemy, x = globals.MAX_X, y = 100, vx = -300, vy = 300}, done = false },
   [300] = { { enemyType = enemy.Boss1}, done = false }
}
