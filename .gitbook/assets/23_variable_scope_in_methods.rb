=begin

- Local Variable.
- Global Variable.
- Instance Variable.
- Class Variable.

Note: You can verify the scope of a variable by using the "defined" keyword beside the variable name. ie,
$value = 7
puts defined? $value # outputs gloal-variable.

=end



$value = 7 # Global variable is available globally.
puts defined? $value
@arr = ['boy', 'girl', 'man', 'woman'] # Instance variable is also available globally.

def welcome
  # accessing both Global and Instance variables here.
  puts "Hello, i am a #{@arr[0]}, and i am #{$value} yrs old."
end
welcome

def longest_word
  # accessing Instance variable here.
  longest_word = @arr.inject do |memo,word|
    memo.length > word.length ? memo : word
  end
  puts "The longest word is #{longest_word}."
end
longest_word

def over_five?
  # defining a Global variable here.
	$x = 3
end
over_five?
puts "I am from the over_five? method/function: #{$x}" # accessing the Global variable.