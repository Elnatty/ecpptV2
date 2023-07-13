# Example 1:
# Long method.
# A way to access Instance Variable:
class Animal
  # setter function/method.
  def noise=(noise) # sets the instance variable for access
    @noise = noise
  end

  # getter method.
  def noise
    @noise
  end
end

a1 = Animal.new
a2 = Animal.new

# puts a1.noise = "Moo!"
a2.noise = "Quack!"
# puts a2.noise

#=========================================
# Example 2:
# Short method.
# A way to access Instance Variable:
#=========================================

=begin

- attr_reader.
- attr_writer.
- attr_accessor.

=end

class Animal
  attr_accessor :name # creates an instance variable that we can access without calling any method.
  attr_writer :color # creates a writer/setter, that we can also access without calling any method.
  attr_reader :legs, :arms # creates a getter/reader, that can be acessed by calling the method in which they are defined in or inside the "def initialize" method, explained in next chapter 29.

  def noise
    return "This is #{@name}, Baaaaah, #{@legs} legs." # we use "@name" to call the ":name" Instance Variable.
  end

  # in order to access the reader instance variable, we have to call the below "read function 1st".
  def read
    @legs = 4
    @arms = 2
  end
end
x = Animal.new
x.name = "Steve"
x.read # we call this function, in order to access the Reader Instance Variables, ie, @legs and @arms.
puts x.noise
puts x.color = "Red" # to use the "@color" writer instance, we must set it 1st.