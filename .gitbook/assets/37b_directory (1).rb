=begin

puts Dir.getwd # get current working directory.
puts Dir.home

Example 1-----------------------
puts Dir.pwd
Dir.chdir("testDir") do puts Dir.pwd end # changes into the specified directory.
puts Dir.pwd

Example 2-----------------------
puts "we are currently in: #{Dir.pwd}"
Dir.chdir("food_finder_app") do 
  puts " we changed to: #{Dir.pwd}"
  x = Dir.mkdir("testD")
  if x == 0
    puts "testD created successfully.."
    Dir.delete("testD")
    puts "testD deleted successfully.."
  else
    puts "error in creating dir.."
  end
end
puts "we are back at #{Dir.pwd}"
====================================
listing in directories
====================================
Example 3 --------------------------
puts Dir.entries(".") # list current dir
Example 4 ------Iterator------------
for i in Dir.entries(".")
  puts i
end
Example 5 --------Iterator----------
Dir.foreach(".") do
  |file| puts file
end


=end
Dir.foreach(".") do
  |file| puts file
end