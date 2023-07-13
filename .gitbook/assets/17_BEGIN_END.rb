BEGIN {
  # this block is run at the begining.
  puts "Beginning of Code.."

}
BEGIN {
  # this block is run after the initial begining block.
  puts "Beginning 1 of Code.."
}

END {
  # this block is run at the end.
  puts "End of Code.."
}

# this can be anything, that runs in the middle of the script.
puts "THis is intended to run in the middle..."