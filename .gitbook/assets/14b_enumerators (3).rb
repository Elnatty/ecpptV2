=begin

In Ruby, an enumerator is an object that allows you to iterate over a collection of elements and perform some operation on each element. An enumerator can be created from an array, a hash, a range, or any other collection of objects that responds to the each method.

An enumerator is created using the to_enum method or the shorthand enum_for method. The resulting enumerator can then be used with iterator methods such as each, map, select, and many others.

Here's an example of creating an enumerator from an array and using it to iterate over the array:

Example 1 --------------------------------
fruits = ["apple", "banana", "orange"]
enum = fruits.to_enum
enum.each do |fruit|
  puts fruit
end
-------------------------------------------
In this example, we create an array of fruits and then create an enumerator from the array using the to_enum method. We then use the each method to iterate over the enumerator and print out each fruit.

Here's another example of creating an enumerator from a hash and using it to iterate over the keys and values of the hash:

Example 2 ----------------------------------
ages = { "Alice" => 30, "Bob" => 20, "Charlie" => 40 }
enum = ages.to_enum
enum.each do |name, age|
  puts "#{name} is #{age} years old."
end
----------------------------------------------
In this example, we create a hash of ages and then create an enumerator from the hash using the to_enum method. We then use the each method to iterate over the enumerator and print out each name and age.

Using enumerators can provide a powerful and flexible way to work with collections of data in Ruby, and can help to make your code more efficient and easier to read.


=================================================
Enumerators
================================================
In Ruby, an external iterator is an iterator that is controlled by the caller, rather than being controlled by the collection being iterated over.

When you use an external iterator, you manually advance the iterator to the next element by calling the next method on the enumerator. This gives you more fine-grained control over the iteration process, and allows you to skip or repeat elements as needed.

Here's an example of using an external iterator with an enumerator:

Example:---------------------------------
numbers = [1, 2, 3, 4, 5]
enum = numbers.to_enum

puts enum.next # Output: 1
puts enum.next # Output: 2
puts enum.next # Output: 3
-----------------------------------------
In this example, we create an enumerator from an array of numbers using the to_enum method. We then manually advance the iterator to the next element three times using the next method, printing out each element as we go.

Using an external iterator can be useful when you need more control over the iteration process, or when you need to perform complex operations on the collection being iterated over. However, it can also make your code more complex and harder to read, so it should be used judiciously.
=end