=begin

puts "hello" + " " + "world" # hello world.
'I\' excaped.' # escapes the "'" i,e I'm excaped.
puts "I said, \"I'm Escaped.\"" # I said, "I'm Escaped."

String Literals.
Example 1.
x = "Dking"
puts "My name is #{x}" # My name is Dking.

Example 2.
x = "DKing"
puts 'My name is #{x}' # single quotes dosen't interpret String Literals. i,e My name is #{x}.

Example 3.
puts "1 + 1 = #{1+1}" # 1 + 1 = 2.

String Methods.
puts "hello".upcase # HELLO.
puts "hello".downcase # hello.
puts "hello".capitalize # Hello.
puts "hello".reverse # olleh.
puts "hello".length # 5.
puts "hello".reverse.upcase.length # you can daisy-chain methods like other languages.

=end