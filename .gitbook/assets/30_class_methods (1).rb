=begin

Class Methods: Animal.new (.new) is a class method that exist  on the class "Animal" even when we don't have an instance.

=end

class Animal
  attr_accessor :name
  attr_writer :color
  attr_reader :legs, :arms

  # Class Method 1.
  def self.all_species
    ['dog', 'cow', 'goat', 'rat', 'pig', 'ram']
  end

  # Class Method 2
  def self.create_attributes(name, color)
    animal = self.new(name)
    animal.color =  color
    return animal
  end

  def initialize(name, legs=4, arms=2)
    @name = name
    @legs = legs
    @arms = arms
    # puts "The initialize method has been called.."
  end

  def color
    "The color is #{@color}"
  end
end
# calling the class instance.
# print Animal.all_species # outputs the array.

x = Animal.create_attributes("Quack", "Red")
puts x.name
puts x.color