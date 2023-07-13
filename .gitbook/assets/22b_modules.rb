=begin

In Ruby, a module is a container for a set of methods, constants, and other module-level objects. Modules provide a way to group related functionality together and share that functionality across different classes and other modules.

Here's an example of how to define a module in Ruby:
Example 1---------------------------------------
module MyModule
  def my_method
    puts "Hello, world!"
  end
end
In this example, we define a module called MyModule that contains a single method called my_method.

Modules can be included in other classes or modules using the include keyword. When a module is included in a class or module, its methods and constants become available to instances of that class or module.

Here's an example of how to include a module in a class in Ruby:
Example 2---------------------------------------
class MyClass
  include MyModule
end

obj = MyClass.new
obj.my_method # Output: "Hello, world!"

In this example, we define a class called MyClass that includes the MyModule module. We then create an instance of MyClass and call the my_method method, which is defined in the MyModule module.

Modules can also be used for namespacing, which helps to avoid naming conflicts between different parts of an application.

Here's an example of how to use a module for namespacing in Ruby:

Example 3 ---------------------------------------
module MyNamespace
  class MyClass
    def my_method
      puts "Hello, world!"
    end
  end
end

obj = MyNamespace::MyClass.new
obj.my_method # Output: "Hello, world!"
In this example, we define a module called MyNamespace that contains a class called MyClass. We then create an instance of MyNamespace::MyClass and call the my_method method.

Overall, modules provide a powerful and flexible way to organize and share code in Ruby, and can help make your code more modular, reusable, and easier to maintain.