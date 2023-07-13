=begin

================================
Inject: is an Accumulator.
================================
Example 1:------------------------
x = (1..10).inject {|sum,i| sum + i}
print x

Example 2:------------------------
x = (1..5).inject(15) {|sum,i| sum + i} # starting number is "15".
print x

Example 3:
fruits = ['apple', 'mangoes', 'guava', 'pear']

# fetching the longest fruit in the array.
x = fruits.inject do |memo,f|
  if memo.length > f.length
    memo
  else
    f
  end
end
print x

=end
