module (..., package.seeall)

-- Object system documentation
---- To create a brand new class with some state:
----    Foo = object.create({a = nil, b = nil, c = 5})
---- To create a new class with a superclass:
----    Bar = object.create({}, Foo)
---- After creating a class 'Foo', the method 'Foo:initialise()'
---- should be implemented, which is the constructor.
--
---- To get an instance of a class we have already created:
----    instance = Foo.create()
----    instance:initialise(...)
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
---- inherited from.
function create(state, superclass)
   local new_class = {}

   function new_class:create()
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
      if superclass then
         new_inst.super = superclass:create()
         setmetatable(new_inst, { __index = new_inst.super })
      else
         new_inst.super = nil
      end

      return new_inst
   end

   return new_class
end