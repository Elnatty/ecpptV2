#!/usr/bin/ruby


=begin

======================================================
Methods here are same as Functions in other Languages.
======================================================

Example:-----------------------------
def welcome
  print "Hello World"
end
welcome # calling the function/method.

Example 2-----------------------------
# function/methods names can have the "?" which is normally used to return boolean values for esting purposes.
def over_five?
  value = 10
  value > 5 ? true : false
end
puts over_five?


=end
def welcome
  return "Hello World"
end

# function/methods names can have the "?" which is normally used to return boolean values for esting purposes.
def over_five?
  value = 10
  value > 5 ? true : false
end
puts over_five?
puts welcome

# we can also use alias on methods/functions names.
alias wel welcome
puts "calling alias: #{wel}"

# Note: in order to make these functions/methods available to the "irb" terminal:
# 1. type puts $LOAD_PATH in irb to get ruby path.
# 2. add any of the path to the beginning of the script.
# 3. in "irb" use require "script_name" to import to script, which will make the defined methods/functions available for use in the "irb" terminal.