=begin

=======================================
Sort or the "<=>" (space ship operator)
=======================================
Used to compare 2 values.
- -1 is returned if Less than, and Moves "left"
- 0 is returned if Equal, and "Stays".
- 1 is returned if More than, and Moves "right".

Example 1:-----------------------------
puts 1 <=> 2 # returns -1
puts 1 <=> 1 # returns 0
puts 2 <=> 1 # returns 1

Example 2:
arr = [3,4,2,1,4,5,2]
x = arr.sort {|v1,v2| v1 <=> v2} # the v1 and v2 are used to compare.
print x # outputs [1, 2, 2, 3, 4, 4, 5]. which sorts the array in ascending order. or we could just pass sort without any complex code and it does same thing.

print arr.sort

Example 3: Reverse sorting.
print arr.sort {|v1,v2| v2 <=> v1} # outputs [5, 4, 4, 3, 2, 2, 1].

which can be done with...
print arr.sort.reverse

Example 4:
fruits = ['apple', 'mango', 'guava', 'pear']
print fruits.sort {|fruit1,fruit2| fruit1 <=> fruit2} # sorts the strings in ascending order.

Example 5:
print fruits.sort {|fruit1,fruit2| fruit1.length <=> fruit2.length} # sorts the fruits by length.

or we could use the "Sort_by" method.

print fruits.sort_by {|fruit| fruit.length}
print fruits.sort_by {|fruit| fruit.reverse}


Example 6:-------------------------------
=========================
sorting Hashes.
=========================
hash = {
  'c'=>555, 'a'=>444, 'd'=>111, 'b'=>333
}
a = hash.sort {|item1,item2| item1[0] <=> item2[0]} # sorts them by their keys

b = hash.sort {|item1,item2| item1[1] <=> item2[1]} # sorts them by their values

# print a
print b

=end

