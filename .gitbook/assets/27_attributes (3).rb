=begin

We use the Instance Variable in this case. ie, @variable
The scope of an Instance Variable is inside all of the methods of the instanstance, but not outside of the instance.

Note: Instance Variable can only be assessed from methods.


=end

class Animal
  def set_noise
    @noise = "Moo"
  end

  def make_noise
    @noise = "Quack"
  end
end

a1 = Animal.new
a2 = Animal.new

puts a1.set_noise
puts a2.make_noise