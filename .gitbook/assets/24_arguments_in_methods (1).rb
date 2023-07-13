# 1 argument "name" required.
def welcome(name)
  puts "my name is #{name}"
end
welcome("Dking") # one way to call it.
welcome "Philip"

# ====================================
# Argument Default Value
# ====================================

def add(x,y=10)
  puts x + y
end
add(20)