module(..., package.seeall);

require "enemies"
require "globals"
require "resources"

music = "gensou.ogg"
background = "background.png"

-- Timings are in deciseconds
script   = {
   [5]   = { { enemyType = enemies.BasicEnemy, x = 100, y = 0, vy = 500, ay = -200 },
	     { enemyType = enemies.BasicEnemy, x = 400, y = 0, vy = 500, ay = -200 }, done = false },
   [10]  = { { enemyType = enemies.BasicEnemy, x = 200, y = 0, vy = 500, ay = -200 },
	     { enemyType = enemies.BasicEnemy, x = 300, y = 0, vy = 500, ay = -200 }, done = false },
   [40]  = { { enemyType = enemies.BasicEnemy, x = 0, y = 100, vx = 200, vy = 0 }, done = false },
   [45]  = { { enemyType = enemies.BasicEnemy, x = 0, y = 100, vx = 200, vy = 0 }, done = false },
   [50]  = { { enemyType = enemies.BasicEnemy, x = 0, y = 100, vx = 200, vy = 0 }, done = false },
   [55]  = { { enemyType = enemies.BasicEnemy, x = 0, y = 100, vx = 200, vy = 0 }, done = false },
   [100] = { { enemyType = enemies.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},
   [105] = { { enemyType = enemies.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},
   [110] = { { enemyType = enemies.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},
   [115] = { { enemyType = enemies.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},
   [120] = { { enemyType = enemies.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},
   [125] = { { enemyType = enemies.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},
   [130] = { { enemyType = enemies.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},
   [135] = { { enemyType = enemies.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},
   [140] = { { enemyType = enemies.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},
   [145] = { { enemyType = enemies.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},
   [150] = { { enemyType = enemies.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},
   [155] = { { enemyType = enemies.BasicEnemy, x = globals.MAX_X, y = 200, vx = -400, vy = 0, ax = 200, ay = 120}, done = false},

   [200] = { { enemyType = enemies.BasicEnemy, x = 0, y = 100, vx = 300, vy = 300},
	     { enemyType = enemies.BasicEnemy, x = globals.MAX_X, y = 100, vx = -300, vy = 300}, done = false },
   [210] = { { enemyType = enemies.BasicEnemy, x = 0, y = 100, vx = 300, vy = 300},
	     { enemyType = enemies.BasicEnemy, x = globals.MAX_X, y = 100, vx = -300, vy = 300}, done = false },
   [220] = { { enemyType = enemies.BasicEnemy, x = 0, y = 100, vx = 300, vy = 300},
	     { enemyType = enemies.BasicEnemy, x = globals.MAX_X, y = 100, vx = -300, vy = 300}, done = false },
   [230] = { { enemyType = enemies.BasicEnemy, x = 0, y = 100, vx = 300, vy = 300},
	     { enemyType = enemies.BasicEnemy, x = globals.MAX_X, y = 100, vx = -300, vy = 300}, done = false },
   [240] = { { enemyType = enemies.BasicEnemy, x = 0, y = 100, vx = 300, vy = 300},
	     { enemyType = enemies.BasicEnemy, x = globals.MAX_X, y = 100, vx = -300, vy = 300}, done = false },
   [300] = { { enemyType = enemies.Boss1}, done = false }
}
