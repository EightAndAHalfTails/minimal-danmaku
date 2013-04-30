module(..., package.seeall);

require "enemies"
require "globals"
require "resources"

music = "gensou.ogg"
background = "background.png"

-- Timings are in deciseconds
script = 
{
   [5]   = { { enemy = enemies.BasicEnemy, args = { 100, 0  , 0  , 500, 0  ,-200 } },
	     { enemy = enemies.BasicEnemy, args = { 400, 0  , 0  , 500, 0  ,-200 } }, done = false },
   [10]  = { { enemy = enemies.BasicEnemy, args = { 200, 0  , 0  , 500, 0  ,-200 } },
	     { enemy = enemies.BasicEnemy, args = { 300, 0  , 0  , 500, 0  ,-200 } }, done = false },
   [40]  = { { enemy = enemies.BasicEnemy, args = { 0  , 100, 200, 0  , 0  , 0   } }, done = false },
   [45]  = { { enemy = enemies.BasicEnemy, args = { 0  , 100, 200, 0  , 0  , 0   } }, done = false },
   [50]  = { { enemy = enemies.BasicEnemy, args = { 0  , 100, 200, 0  , 0  , 0   } }, done = false },
   [55]  = { { enemy = enemies.BasicEnemy, args = { 0  , 100, 200, 0  , 0  , 0   } }, done = false },
   [100] = { { enemy = enemies.BasicEnemy, args = { globals.MAX_X, 200,-400, 0  , 200, 120} }, done = false},
   [105] = { { enemy = enemies.BasicEnemy, args = { globals.MAX_X, 200,-400, 0  , 200, 120} }, done = false},
   [110] = { { enemy = enemies.BasicEnemy, args = { globals.MAX_X, 200,-400, 0  , 200, 120} }, done = false},
   [115] = { { enemy = enemies.BasicEnemy, args = { globals.MAX_X, 200,-400, 0  , 200, 120} }, done = false},
   [120] = { { enemy = enemies.BasicEnemy, args = { globals.MAX_X, 200,-400, 0  , 200, 120} }, done = false},
   [125] = { { enemy = enemies.BasicEnemy, args = { globals.MAX_X, 200,-400, 0  , 200, 120} }, done = false},
   [130] = { { enemy = enemies.BasicEnemy, args = { globals.MAX_X, 200,-400, 0  , 200, 120} }, done = false},
   [135] = { { enemy = enemies.BasicEnemy, args = { globals.MAX_X, 200,-400, 0  , 200, 120} }, done = false},
   [140] = { { enemy = enemies.BasicEnemy, args = { globals.MAX_X, 200,-400, 0  , 200, 120} }, done = false},
   [145] = { { enemy = enemies.BasicEnemy, args = { globals.MAX_X, 200,-400, 0  , 200, 120} }, done = false},

   [200] = { { enemy = enemies.BasicEnemy, args = { 0            , 100,  300, 300, 0, 0} },
  	     { enemy = enemies.BasicEnemy, args = { globals.MAX_X, 100, -300, 300, 0, 0} }, done = false },
   [210] = { { enemy = enemies.BasicEnemy, args = { 0            , 100,  300, 300, 0, 0} },
  	     { enemy = enemies.BasicEnemy, args = { globals.MAX_X, 100, -300, 300, 0, 0} }, done = false },
   [220] = { { enemy = enemies.BasicEnemy, args = { 0            , 100,  300, 300, 0, 0} },
  	     { enemy = enemies.BasicEnemy, args = { globals.MAX_X, 100, -300, 300, 0, 0} }, done = false },
   [230] = { { enemy = enemies.BasicEnemy, args = { 0            , 100,  300, 300, 0, 0} },
  	     { enemy = enemies.BasicEnemy, args = { globals.MAX_X, 100, -300, 300, 0, 0} }, done = false },
   [240] = { { enemy = enemies.BasicEnemy, args = { 0            , 100,  300, 300, 0, 0} },
  	     { enemy = enemies.BasicEnemy, args = { globals.MAX_X, 100, -300, 300, 0, 0} }, done = false },

   [300] = { { bullet = bullets.Rocket, args = { 100, 100, -20, 200, 0, -400, 1, 30 } },
	    { bullet = bullets.Rocket, args = { 200, 100, -10, 200, 0, -400, 1, 30 } },
	    { bullet = bullets.Rocket, args = { 300, 100,  10, 200, 0, -400, 1, 30 } },
	    { bullet = bullets.Rocket, args = { 400, 100,  20, 200, 0, -400, 1, 30 } }, done = false },

   [30] = { { enemy = enemies.Boss1}, done = false },
}
