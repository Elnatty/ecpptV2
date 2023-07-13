class Animal
  def make_noise
    return "moo!"
  end
end
a = Animal.new # instantiating an object/instance for the class.
puts a.make_noise.upcase # we can apply methods and modify further.