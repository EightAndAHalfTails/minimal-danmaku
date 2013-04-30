module (..., package.seeall)

Object = {}

function Object:__create__()
   local new_inst = {}

   new_inst.super = nil

   for k, v in pairs(Object) do
      new_inst[k] = v
   end

   return new_inst
end

function Object:initialise()
end

function Object:new()
   local new_inst = Object:__create__()
   new_inst:initialise()
   return new_inst
end

function Object:deinitialise()
end
