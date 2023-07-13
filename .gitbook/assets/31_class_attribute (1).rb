=begin

Class attributes use the "Class Variable" @@variable

We can access the class attributes in "irb" terminal by:
load 'scrpt_name.rb'
Then all the Class Attributes becomes available for use.

=end

class Animal
  attr_accessor :name
  attr_writer :color
  attr_reader :legs, :arms

  # Class Variable/Attribute
  @@species = ['dog', 'cow', 'goat', 'rat', 'pig', 'ram']
  @@current_animals = []

  # getter method.
  def self.species
    @@species
  end

  # setter method.
  def self.species=(array=[])
    @@species = array
  end

  def self.current_animals
    @@current_animals << "dog" # appending dog to the empty array.
  end

  # Class Method
  def self.create_attributes(name, color)
    animal = self.new(name)
    animal.color =  color
    return animal
  end

  def initialize(name, legs=4, arms=2)
    @name = name
    @legs = legs
    @arms = arms
  end

  def color
    "The color is #{@color}"
  end
end

puts Animal.current_animals
Animal.species = ['frog', "donkey"] # setting the setter/writer class method.
print Animal.species