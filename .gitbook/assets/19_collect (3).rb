=begin

=========================================
Collect / Map can be used interchangably.
Always returns an array.
=========================================
Mostly used with:
- Arrays.
- Hashes.
- Ranges.

Example 1 -------------------------------
arr = [1,2,3,4,5]
fruit = ['apple', 'mango', 'guava', 'pear']
print arr.collect {|i| i**2},"\n"
print fruit.map {|i| i.upcase}

Example 2 -------------------------------
fruit.map do |i|
  if i == "mango"
    i.upcase
  else
    i
  end
end


=end