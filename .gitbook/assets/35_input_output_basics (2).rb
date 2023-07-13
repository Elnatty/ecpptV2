#!/usr/bin/ruby
=begin

Example 1------------------------------------------
Getting Input from user
We can use the ".chomp" method to remove any trace of "\n, \t, \r" etc. in the returned string.
--------------------------------------------------
input = gets.chomp
puts "Welcome, #{input.chomp}"

Example 2:
result = ""
until result == "quit"
  print "enter name: "
  result = gets.chomp
  puts "I heard: #{result}"
end
puts "Goodbye!"

=end