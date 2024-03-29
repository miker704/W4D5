require 'benchmark'

# Largest Contiguous Sub-sum
# You have an array of integers and you want to find 
# the largest contiguous (together in sequence) sub-sum. 
# Find the sums of all contiguous sub-arrays and return the max.

# Example:

#     list = [5, 3, -7]
#     largest_contiguous_subsum(list) # => 8

#     # possible sub-sums
#     [5]           # => 5
#     [5, 3]        # => 8 --> we want this one
#     [5, 3, -7]    # => 1
#     [3]           # => 3
#     [3, -7]       # => -4
#     [-7]          # => -7
# # Example 2:

    # list = [2, 3, -6, 7, -6, 7]
    # largest_contiguous_subsum(list) # => 8 (from [7, -6, 7])
# Example 3:

    list = [-2, -5, -1, -3]
    # largest_contiguous_subsum(list) # => -1 (from [-1])

    # Phase I
    # Write a function that iterates through the array 
    # and finds all sub-arrays using nested loops. First make an
    #  array to hold all sub-arrays. Then find the sums of each 
    #  sub-array and return the max.
    # Discuss the time complexity of this solution. most likely O(N^2)
    
    def largest_contiguous_subsum(list)
        subArray=[]
        list.each_with_index do |num1,i|
            list.each_with_index do |num2,j|
                subArray<<[num1,num2] if i < j
            end
        end
        subArray.map  {|sub| sub.sum}.max
    end

    # puts largest_contiguous_subsum(list)

    # Phase II
    # Let's make a better version. Write a new function using O(n) time with O(1) memory. 
    # Keep a running tally of the largest sum. To accomplish this 
    # efficient space complexity, consider using two variables. 
    # One variable should track the largest sum so far and another 
    # to track the current sum. We'll leave the rest to you.
    
    def largest_contiguous_subsum_n(list)
        largest_sum = list.min + list.min
        current_sum = list.min + list.min
        (0...list.length-1).each do |i|
            if list[i] + list[i+1] > current_sum
                current_sum = list[i] + list[i+1]
                if current_sum > largest_sum 
                    largest_sum = current_sum
                end
            end
        end
        largest_sum
    end

    # puts largest_contiguous_subsum_n(list)





    # Get your story straight, and then explain your solution's 
    # time complexity to your TA.
    list = [2, 3, -6, 7, -6, 7]
    list2 = [5, 3, -7]
    list3 = [-5, -1, -3]
    random_list=(0..10_000).to_a.shuffle
    Benchmark.bmbm do |x|
        x.report("largest_contigous_subsum(list)") { largest_contiguous_subsum(list) }
        x.report("largest_contigous_subsum(list2)") { largest_contiguous_subsum(list2) }
        x.report("largest_contigous_subsum(list3)") { largest_contiguous_subsum(list3) }
        x.report("largest_contigous_subsum(random_list)") { largest_contiguous_subsum(random_list) }

        x.report("largest_contiguous_subsum_n(list)") { largest_contiguous_subsum_n(list) }
        x.report("largest_contiguous_subsum__nn(list2)") { largest_contiguous_subsum_n(list2) }
        x.report("largest_contiguous_subsum_n(l_nist3)") { largest_contiguous_subsum_n(list3) }
        x.report("largest_contiguous_subsum_n(random_list)") { largest_contiguous_subsum_n(random_list) }
      end

