module (..., package.seeall)

local _NAME = (...)

object = require(_NAME .. ".object")

-- Object system documentation
---- To create a brand new class with some state:
----    Foo = object.create({a = nil, b = nil, c = 5})
---- To create a new class with a superclass:
----    Bar = object.create({}, Foo)
---- After creating a class 'Foo', the method 'Foo:initialise()'
---- may be implemented, which is the constructor. Similarly, the
---- method 'Foo:deinitialise()' may be implemented, which is the
---- deconstructor. This must be explicitly called, before deleting an
---- object.
--
---- To get an instance of a class we have already created:
----    instance = Foo:new(...)
--
---- To access an instance's state:
----    instance.foo
--
---- To call a method on an instance:
----    instance:foo(...)

-- Create a class
---- The state is the initial state for a class, complete with all
---- uninitialised variables. Any initialisation which requires player
---- input should be done in the constructor. "super" and the names of
---- any methods of the class are prohibited from being variable names.
--
---- The superclass, if given, is a class that methods and state is
---- inherited from. If one is not given, Object is used.
function create(state, superclass)
   local new_class = {}
   
   if superclass == nil then
      superclass = object.Object
   end

   function new_class:__create__()
      local new_inst = {}

      -- Copy the state
      for k, v in pairs(state) do
         new_inst[k] = v
      end

      -- Copy the methods
      for k, v in pairs(new_class) do
         new_inst[k] = v
      end

      -- Set up the superclass
      new_inst.super = superclass:__create__()

      -- Set up the metatable
      local new_inst_mt = {}

      new_inst_mt.__index = new_inst.super

      new_inst_mt.__newindex = function(table, key, value)
         if table.super[key] then
            table.super[key] = value
         else
            rawset(table, key, value)
         end
      end

      setmetatable(new_inst, new_inst_mt)

      return new_inst
   end

   function new_class:new(...)
      local new_inst = new_class:__create__()
      new_inst:initialise(...)
      return new_inst
   end

   return new_class
end