=begin
================================
Keywords for Exception Handling
================================
begin
  # normal code flow.
rescue
  # exception handling.
  retry
else
  # no exception occur.
ensure
  # alwayw executed.
end

Note: any of the Keywords can be used without the begin keyword.
=end


# using retry.
def divide(x, y)
  result = "#{x} / #{y} = #{x/y}"
  rescue ZeroDivisionError => e
    puts "Error: #{e.message}"
    puts "Retrying with y = 5..."
    y = 5
    retry

  return result
end

puts divide(10, 0) # Output: "Error: divided by 0" "Retrying with y = 5..." 2
# puts divide(10, 2) # Output: 5