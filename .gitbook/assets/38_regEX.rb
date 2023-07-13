=begin

=========================
Pattern Matching Operator
=========================
Regex Objects:
- Literal notation - /Hello/
- {} delimiter     - %r{Hello}
- ! delimiter      - %r!Hello!
- OO notation      - Regexp.new("Hello")
- OO notation      - Regexp.compile("Hello")

=========================
Regex syntax rules
. a single character (does not match new line)
[] at least one of the characters inside here.
[^ ] at least one of the characters not inside.
\d a digit 0 - 9
\D a non digit
\s a white space
\S a non whitespace
\w a word character A-Za-z
\W a non word character
==========================
Regex Repition rules
exp* Zero or more occurence of exp.
exp+ One or more occurence.
exp? Zero or One occurence.
exp{n} n occurence of exp.
exp{n,} n or more occurence of exp.
exp{n,m} at least n and at most m occurence of exp.
==========================
Regex Anchors
^exp exp must be at the begin of a line.
exp$ exp must be at the end of a line.
\Aexp exp must be at begin of the whole string.
exp\Z exp must be at end of the whole string.
exp\z same as \Z but must match newline too.
==========================

Example 1 ---------------
The operator "=~" is used to match patterns.
puts "Hello World" =~ /world/
puts "Hello World" =~ /lo/i # for case insensitive matching.

Example 2 ---------------
Matching 
puts /world/i.match("Hello World") # matches "World".

Example 3 ---------------
puts /\(/i.match("(Hello World)") # to match "(" we have to escape it with "\" ie, /\(/

Example 4 ---------------
puts /\d[A-Z]/i.match("Code: 4B") # matches 4B.
puts /ruby|rubber/i.match("I'm Ruby") # matches Ruby.

Example 5 ---------------
puts /(ruby){3}/i.match("RubyRubyRuby") # matches

Example 6 ---------------
ip a | grep -E  "([0-9]{1,3}).([0-9]{1,3}).([0-9]{1,3}).([0-9]{1,3})" -o # matching ip address in linux.

==========================
When working with RegEX, Ruby automatically sets some Global variable;
==========================
$~ the matchdata object of the last match.
$& the substring that match the 1st group pattern.
$1 the substring that match the 2nd group pattern.
$2,$3,etc.. and so on.
Example 1 ----------------
puts "Hello World !!!" =~ /^(hello)\s(world)\s(!!!)$/i
puts $& # outputs "Hello World"
puts $1 # outputs "Hello"
puts $2 # outputs "world"
puts $3 # outputs "!!!"
Example 2 ----------------
puts "Hello World !!!, Hello World".gsub(/(hello)/i, "Hy") # replace all occurence of the pattern.

Example 3 ----------------
text = "abcd 192.168.0.1 some text 192.168.100.10 and 172.16.10.5 is here."
pattern = /(?:\d{1,3}.){3}(?:\d{1,3})/ # ?:exp avoids capturing the subexpression inside () so only the entire external expression is captured (the ip address).
puts text.scan(pattern)

==========================
Date & Time
==========================
puts Time.new # current date and time
puts Time.now # current date and time
puts Time.new.utc # current time converted in UTC.
puts Time.local(2023,06,30) # creates a datetime object.
puts Time.now.tuesday? # returns boolean.
puts Time.new.strftime("%d/%m/%Y") # current date.
puts Time.new.strftime("%I:%M:%S %P,%p") # current time.

=end
