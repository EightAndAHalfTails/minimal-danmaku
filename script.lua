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
   if entry.enemy then
      --print(entry.enemy, unpack(entry.args or {}))
      local new = entry.enemy:create()
      new:initialise(unpack(entry.args or {}))
      table.insert(globals.enemies, new)
   end
   if entry.bullet then
      local new = entry.bullet:create()
      new:initialise(unpack(entry.args or {}))
      table.insert(globals.bullets, new)
   end
end

function dispatch(stage)
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
   preserved.score  = globals.player.score
end

function reset()
   if globals.stage then
      for k, v in pairs(preserved) do
         globals.player[k] = v
      end

      dispatch(globals.stage)
   end
end

function load()
   dispatch(globals.assets.stages[1])
end
