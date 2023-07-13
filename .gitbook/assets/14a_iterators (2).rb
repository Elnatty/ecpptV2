=begin

Example 1:
5.times do
  puts "Hello"
end

Example 2:
1.upto(5) {puts "yo"} # iterates 5 times and prints "yo"

Example 3:
5.downto(1) {puts "Counting Down.."}

Example 4:
(1..5).each {puts "Hello"}

Example 5:
1.upto(10) do |x|
  puts "Hello at #{x}"
end

Example 6:
Looping through List.
names = ['DKing', "Hannah", "Nathan"]
names.each do |name|
  puts "My name is #{name.upcase}."
end

Example 7:
Same with example 6.
names = ['DKing', "Hannah", "Nathan"]
for i in names
  puts i.upcase
end


-----------------In Summary--------------------
1. Integers/Floats: times, upto, downto, step.
2. Range: each, step, map, select, reject, detect, find_all.
3. String: each_line, each_byte, each_char, chars, lines, bytes.
4. Array: each, map/select, inject, reject, detect, find_all, reduce, zip, each_index, each_with_index.
5. Hash: each, each_key, each_value, each_pair, map, reject, detect, find_all, reduce.
-----------------------------------------------

=end
a = "DKing"
a.each_char {|i| print i.upcase}