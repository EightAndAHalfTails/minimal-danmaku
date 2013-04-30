module(..., package.seeall)

-- Metamethods common to all objects
function __eq(left, right)
   return left:__eq__(right)
end

function __lt(left, right)
   return left:__lt__(right)
end

function __le(left, right)
   return left < right or left == right
end
