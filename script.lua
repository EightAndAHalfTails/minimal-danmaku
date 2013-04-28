module(..., package.seeall)

local stage = 1
local time = 0.0

Script = nil

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

function load(script)
   Script = script
end