module (..., package.seeall)

sprites = {}
sprite_dir = "res/sprite/"

sounds = {}
sound_dir = "res/sound/"

backgrounds = {}
background_dir = "res/bg/"

function load()
   -- Load all game resources
   for i, file in ipairs(love.filesystem.enumerate(sprite_dir)) do
      sprites[file] = love.graphics.newImage(sprite_dir .. file)
   end

   for i, file in ipairs(love.filesystem.enumerate(sound_dir)) do
      sounds[file] = love.audio.newSource(sound_dir .. file)
   end

   for i, file in ipairs(love.filesystem.enumerate(background_dir)) do
      backgrounds[file] = love.graphics.newImage(background_dir .. file)
   end
end
