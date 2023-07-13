=begin

Types of Ranges
1. Inclusive Range: 1..10
    1,2,3,4,5,6,7,8,9,10

2. Exclusive Range: 1...10
    1,2,3,4,5,6,7,8,9

Examples 1
x = 1..5 # range.
[*x] # outputs [1,2,3,4,5]
x.begin # 1.
x.end # 5.
x.first # 1
x.last # 5
x.include.(1) # true.

Eg 2
a = 'a'..'z'
[*a] # outputs the entire alphabet table.

=end