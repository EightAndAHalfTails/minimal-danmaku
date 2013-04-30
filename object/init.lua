module (..., package.seeall)

local _NAME = (...)
package.path = _NAME .. "/?.lua;" .. package.path
object = require(_NAME .. ".object")
mms = require(_NAME .. ".metamethods")

-- Object system documentation
---- To create a brand new class subclassing Object:
----    Foo = object.create()
---- To create a new class with a superclass:
----    Bar = object.create(Foo)
---- After creating a class 'Foo', the method 'Foo:initialise()'
---- may be implemented, which is the constructor. Similarly, the
---- method 'Foo:deinitialise()' may be implemented, which is the
---- deconstructor. This must be explicitly called, before deleting an
---- object.
--
---- To get an instance of a class we have already created:
----    instance = Foo(...)
--
---- To access an instance's state:
----    instance.foo
--
---- To call a method on an instance:
----    instance:foo(...)
--
---- See Object for documentation of all of the standard methods.

-- Create a class
---- The superclass, if given, is a class that methods and state is
---- inherited from. If one is not given, Object is used.
function create(superclass)
   local new_class = {}
   
   if superclass == nil then
      superclass = object.Object
   end

   function new_class:__create__()
      local new_inst = {}

      -- Copy the state and methods
      for k, v in pairs(new_class) do
         new_inst[k] = v
      end

      -- Set up the superclass
      new_inst.super = superclass:__create__()

      -- Set up the metatable
      new_inst.__metatable__ = {}
      setmetatable(new_inst, new_inst.__metatable__)

      new_inst.__metatable__.__index = function(table, key)
         return new_inst.super[key]
      end

      new_inst.__metatable__.__newindex = function(table, key, value)
         if table.super[key] then
            table.super[key] = value
         else
            rawset(table, key, value)
         end
      end

      new_inst.__metatable__.__eq = mms.__eq
      new_inst.__metatable__.__lt = mms.__lt
      new_inst.__metatable__.__le = mms.__le

      return new_inst
   end

   function new_class:__new__(...)
      local new_inst = new_class:__create__()
      new_inst:initialise(...)
      return new_inst
   end

   function new_class:__eq__(other)
      return self.super == other
   end

   function new_class:__lt__(other)
      return self.super < other
   end

   function new_class:initialise(...)
      self.super:initialise(...)
   end

   function new_class:deinitialise(...)
      self.super:deinitialise(...)
   end

   -- Allow us to make an instance with Class(), rather than Class.__new__()
   setmetatable(new_class, { __call = new_class.__new__ })

   return new_class
end