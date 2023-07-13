=begin

puts File.size("20_sort.rb") # returns the size of file in bytes.
puts File.zero?("20_sort.rb") # checks if file is empty.
puts File.ftype("20_sort.rb") # check if a file or directory.
puts File.writable?("20_sort.rb")
puts File.readable?("20_sort.rb")
puts File.executable?("20_sort.rb")
puts File.atime("20_sort.rb") # last access time.
puts File.mtime("20_sort.rb") # last modified time.
puts File.ctime("20_sort.rb") # creation time.
puts File.absolute_path("20_sort.rb")
puts File.basename("20_sort.rb") # returns file name.
puts File.dirname("20_sort.rb")
puts File.extname("20_sort.rb")
puts File.new("ztest.txt", 'w') # creates new file.
puts File.rename("zt.txt", "zz.txt") # rename file.
puts File.delete("zz.txt") # delete file.
puts File.chmod(0777, "ztest.txt") # change permissions.
puts File.readlines("37c_files.rb") # return all lines from a file in an array.

=end