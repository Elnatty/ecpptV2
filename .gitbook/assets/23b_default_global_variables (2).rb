=begin
Ruby has some default defined global variables.
1. $* array of command line argument.
2. $0 name of the script being executed.
3. $_ last string read by gets.\

=end

# prints the name of the script.
puts "Script name:\t\t#{$0}"

# prints the command line arguments in array format. 1st argument is $*[0]
puts "arguments:\t\t#{$*}"
# or we can use ARGV to print arguments.
puts ARGV

#reads a line and prints it.
puts "write something:\t\t"
$stdin.gets
puts "gets:\t\t\t",$_
