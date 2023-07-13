=begin

CODE BLOCKS: FIND
- find / detect # returns a single object.
- find_all / select # returns an array of objects.
- any? # returns a boolean if value exists.
- all?
- delete_if

Eg 1:
(1..10).find {|i| i % 3 == 0} # find and return just 1st occurence of numbers divisible by 3 in the range 1-10. (same with detect)

Eg 2:
(1..10).find_all {|i| i % 3 == 0} # returns an array of all numbers divisible by 3. (same with select)

Eg 3:
(1..10).any? {|i| i % 3 == 0} # returns a boolean if exists, in this case (true)

Eg 4:
(1..10).all? {|i| i % 3 == 0} # returns false, since not all items here are divisible by 3.

Eg 5:
[*1..10].delete_if {|i| i % 3 == 0} # delete_if dosent work with range operator, instead we se the array operator. This deletes all nubers divisible by 3 in the specified array.


=end