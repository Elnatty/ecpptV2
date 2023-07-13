=begin

The Merge is used for Hash data type. It is usually triggered when a conflicting key:value pair is encountered in a Hash data.

Example 1:-------------------------
h1 = {"a"=>111, "b"=>222}
h2 = {"b"=>333, "c"=>444}

print h1.merge(h2) # makes use of the new value when merging.

Example 2:--------------------------
using a code block to perform certain operations.

h1.merge(h2) {|k,o,n| print o} # takes 3 argument, "k"-key, "o"-old value, "n"-new value to be merged.

Example 3:--------------------------
h1.merge(h2) do |k,o,n|
  if o < n # when there is a conflict, pick the old value.
    o
  else
    n
  end
end

an efficient way to write the above code is to use tenary instead.

puts h1.merge(h2) {|k,o,n| o < n ? o : n}

=end