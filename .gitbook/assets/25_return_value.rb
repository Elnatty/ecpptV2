# Example 1
def add(x,y)
  return x + y
end
puts "The sum of 4 and 5 is = #{add(4,5)}"

# Example 2
def add_and_sub(x,y)
  a = x + y
  b = x - y
  return a, b # returns an array with 2 values.
end
print add_and_sub(10, 7),"\n"
# or
add,sub = add_and_sub(15,12)
puts "add = #{add}\nsub = #{sub}"