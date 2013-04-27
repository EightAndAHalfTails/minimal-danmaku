module (..., package.seeall)

sprites = {}
sprite_dir = "res/sprite/"

function load()
   -- Load all game resources
   for i, file in ipairs(love.filesystem.enumerate(sprite_dir)) do
      sprites[file] = love.graphics.newImage(sprite_dir .. file)
   end
end
