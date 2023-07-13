=begin

======================
File.new and File.open
We can access files by using any of the above cmds.
======================
Creating Files
======================
Example 1 ------------ create a new file.
file = File.new('testfile.txt', 'w')
file.close
Exampe 2 ------------- create a new file.
File.open("file1.txt", 'w') do |file|
  # read file.
end
======================
Writing to Files
======================
File.open("file1.txt", 'w') do |file|
  # writes to file.
  file.puts "This is line 1." # this is best.
  file.write "This is line 2.\n" # no new line.
  file.print "Line 3.\n" # no new line.
  file << "Line 4.\n" # no new line.
end
=======================
Reading from Files.
=======================
Example 1--------------
File.open("file1.txt", 'r') do |file|
  # read from file.
  puts file.gets # output by lines.
  puts file.read(4) # outputs 5 characters from the file.
end
Example 2 -------------
# loop through the entire file.
File.open("file1.txt", 'r') do |file|
  file.each_line {|line| puts line}
end
=======================
File Pointers
=======================
We use ".pos" to print current pointer position or ".pos = 0" to reset the position back to the beginning of the file.

=end

