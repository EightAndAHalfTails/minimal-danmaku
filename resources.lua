module (..., package.seeall)

require "globals"

sprites = {}
relative_sprite_dir = "sprite/"

sounds = {}
relative_sound_dir = "sound/"

backgrounds = {}
relative_background_dir = "bg/"

function load()
   -- Set up directory paths
   sprite_dir     = globals.asset_path .. relative_sprite_dir
   sound_dir      = globals.asset_path .. relative_sound_dir
   background_dir = globals.asset_path .. relative_background_dir

   if not love.filesystem.isDirectory(sprite_dir) then
      error("Could not access sprite directory: " .. sprite_dir)
   end

   if not love.filesystem.isDirectory(sound_dir) then
      error("Could not access sound directory: " .. sound_dir)
   end

   if not love.filesystem.isDirectory(background_dir) then
      error("Could not access background directory: " .. background_dir)
   end

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
