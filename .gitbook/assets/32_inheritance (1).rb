class Animal
  def sound
    return "Baahhh.."
  end
end

# inherits attributes of Animal Class.
class Cow < Animal

end

x = Cow.new
puts x.sound