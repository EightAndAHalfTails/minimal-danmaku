module(..., package.seeall)

require "globals"

tile       = 0.0
script     = nil
background = nil
preserved  = {}

function update(dt)
   time = time + dt*10

   for t, list in pairs(script) do
      if t < time then
	 if not list.done then
	    for i, e in ipairs(list) do
	       --print(e.enemyType)
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

function load(stage)
   -- Music!
   resources.sounds[stage.music]:setLooping(true)
   love.audio.play(resources.sounds[stage.music])

   script = stage.script
   background = resources.backgrounds[stage.background]
   time = 0.0

   for i, e in pairs(globals.enemies) do
      e:deinitialise()
   end

   for i, b in pairs(globals.bullets) do
      b:deinitialise()
   end

   for i, e in pairs(globals.explosions) do
      e:deinitialise()
   end

   globals.enemies    = {}
   globals.bullets    = {}
   globals.explosions = {}

   for t, list in pairs(script) do
      list.done = false
   end

   globals.stage = stage

   preserved.power  = globals.player.power
   preserved.bombs  = globals.player.bombs
   preserved.health = globals.player.health
   preserved.lives  = globals.player.lives
end

function reset()
   if globals.stage then
      for k, v in pairs(preserved) do
         globals.player[k] = v
      end

      load(globals.stage)
   end
end