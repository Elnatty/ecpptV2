=begin

data_set = ["a", "b", "c"]
data_set[0] # fetching items by indexing. a
data_set[0] = "d" # replace items in certain index.
data_set.clear # clear the array.
data_set.class # array.
data_set << "load" # appends item to end of the list or,
data_set.append("bao") # append item to end of the list.

Array Methods.

array = [1,2,3,4,5]
array2 = [1,"2",3.0, ["a","b"], "dog"]

puts array # outputs the array like (a for loop in python).
puts array.inspect # display human readable view.

Example 1:
array.inspect # display human readable view of the array value.

Eg 2:
puts array.join # joins everything together i,e 12345.
puts array.join(", ") # we can add a delimiter here i,e 1, 2, 3, 4, 5
puts.array.to_s # converts array to String i,e [1,2,3,4,5]

Eg 3:
Just like in python, we can convert Arrays to string and Strings back to Array.
puts array.join(", ") # convert Array to String.
puts "1,2,3,4,5".split() # convert String to Array.

Eg 4:
array2.reverse # reverse the array.
array << 0 # appends 0 to the end of the list i,e [1,2,3,4,5,0].
array.sort # sorts list in ascending order, but wont work on arrays with mixed data types unless with complex "sort() cmd".

Eg 5:
array.uniq # removes duplicate values from list temporally.
array.uniq! # removes duplicate values from list permanently.

Eg 6:
array.delete_at(2) # removes item at index 2 position.
array.delete(3) # removes item 3. Used if you don't know a value index.
array.push(4) # adds value 4 to the end of the list just like "<<" and "append".
array.pop # removes the last value in the list.
array.shift() # removes the 1st value in the list.
array.unshift(1) # adds 1 to the beginning of the list.

Eg 7:
array + [10,20,30] # adds 2 arrays together.

=end