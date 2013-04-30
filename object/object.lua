module (..., package.seeall)

mms = require("metamethods")

-- Unfortunately, to avoid a cyclic module dependency, some code
-- duplication between here and init.lua will inevitably occur.

Object = {}

-- Create a new instance of the class, without initialising it. This
-- separation is necessary, because we also want to be able to
-- initialise superclasses, without instantiating them again.
function Object:__create__()
   local new_inst = {}

   new_inst.super = nil

   for k, v in pairs(Object) do
      new_inst[k] = v
   end

   -- Set up the metatable
   new_inst.__metatable__ = {}
   setmetatable(new_inst, new_inst.__metatable__)

   new_inst.__metatable__.__eq = mms.__eq
   new_inst.__metatable__.__lt = mms.__lt
   new_inst.__metatable__.__le = mms.__le

   return new_inst
end

-- Create and initialise a new instance of the class. A shorthand for
-- this method is Class(...).
function Object:__new__(...)
   local new_inst = Object:__create__()
   new_inst:initialise(...)
   return new_inst
end

-- Check if this object is equal to another. This only gets called if
-- the objects are distinct instances.
function Object:__eq__(other)
   return false
end

-- Check if this object is less than another object. Greater-than
-- checking is achieved by checking if this object is less than the
-- other.
-- Together, __eq__ and __lt__ are used to implement ==, ~=, <, >, <=,
-- and >=.
function Object:__lt__(other)
   return false
end

-- Constructor method: do any initialisation that cannot be done when
-- the class is defined.
function Object:initialise(...)
end

-- Destructor method: this is not called automatically when the object
-- is garbage collected, as Lua only supports custom garbage
-- collection for userdata. Thus, this method *must* be called
-- manually before you garbage-collect an instance.
function Object:deinitialise(...)
end

setmetatable(Object, { __call = Object.__new__ })
