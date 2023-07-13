=begin

Eg 1:
x = 0
loop do
  x+=1
  break if x == 5
  puts "x is #{x}"
end

Eg 2:
x = 0
loop do
  x+=1
  break if x == 10
  next if x == 6 # skips 6, just like "continue in python."
  puts "x is #{x}"
end

Eg 3:
x = 1
while x != 10
  x+=1
  puts "x is #{x}"
end

=end