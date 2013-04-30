module (..., package.seeall)

require "globals"

sprites = {}
relative_sprite_dir = "sprite/"

bgm = {}
relative_bgm_dir = "bgm/"

sfx = {}
relative_sfx_dir = "sfx/"

backgrounds = {}
relative_background_dir = "bg/"

function load()
   -- Set up directory paths
   sprite_dir     = globals.asset_path .. relative_sprite_dir
   bgm_dir      = globals.asset_path .. relative_bgm_dir
   sfx_dir      = globals.asset_path .. relative_sfx_dir
   background_dir = globals.asset_path .. relative_background_dir

   if not love.filesystem.isDirectory(sprite_dir) then
      error("Could not access sprite directory: " .. sprite_dir)
   end

   if not love.filesystem.isDirectory(bgm_dir) then
      error("Could not access bgm directory: " .. bgm_dir)
   end

   if not love.filesystem.isDirectory(sfx_dir) then
      error("Could not access sfx directory: " .. sfx_dir)
   end

   if not love.filesystem.isDirectory(background_dir) then
      error("Could not access background directory: " .. background_dir)
   end

   -- Load all game resources
   for i, file in ipairs(love.filesystem.enumerate(sprite_dir)) do
      sprites[file] = love.graphics.newImage(sprite_dir .. file)
   end

   for i, file in ipairs(love.filesystem.enumerate(bgm_dir)) do
      bgm[file] = love.audio.newSource(bgm_dir .. file)
   end

   for i, file in ipairs(love.filesystem.enumerate(sfx_dir)) do
      sfx[file] = love.sound.newSoundData(sfx_dir .. file)
   end

   for i, file in ipairs(love.filesystem.enumerate(background_dir)) do
      backgrounds[file] = love.graphics.newImage(background_dir .. file)
   end
end
