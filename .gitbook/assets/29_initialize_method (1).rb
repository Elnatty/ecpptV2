=begin

The Initialize Method is just like the "def __init__(self)" in python. It is used to initialize instance variables as well as anyother code which gets executed when the script is run.

Note: Once the initialize method is defined, we are able to access the "attr_reader" values automatically.

Note:
- attr_accessor is same as attr :name,true # both can be used for setter/getter.
- attr_reader is same as attr # both are getters.

=end

class Animal
  attr_accessor :name
  attr_writer :color
  attr_reader :legs, :arms

  def initialize(name, legs=4, arms=2)
    @name = name
    @legs = legs
    @arms = arms
    # puts "The initialize method has been called.."
  end

end

x = Animal.new("Dking") # this alone executes the initialize method.
puts "My name is #{x.name}, with #{x.legs} legs and #{x.arms} arms."