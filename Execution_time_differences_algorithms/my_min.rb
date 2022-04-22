require 'benchmark'


# my_min
# Given a list of integers find the smallest number in the list.

# Example:

    # list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
    # my_min(list)  # =>  -5
# Phase I
# First, write a function that compares each element 
# to every other element of the list. Return the element if 
# all other elements in the array are larger.
# What is the time complexity for this function?

# use of linear search algorithim 

def bubble_search_why?(list)
   
    target=0
    list.each_with_index do |ele1,i|
        target = ele1 if ele1 < target
    list.each_with_index do |ele2,j|
        if target > ele2
            target=ele2
        end
    end
    end
    return target 
end

#time complexity is O(N^2)


list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
p bubble_search_why?(list)  # =>  -5
# puts Benchmark.measure(bubble_search_why?(list))
# Benchmark.bmbm do |x|
#     x.report("bubblesearch") { bubble_search_why?(list) }
#     # x.report("sort")  { array.dup.sort  }
#   end



# Phase II
# Now rewrite the function to iterate through the 
# list just once while keeping track of the minimum. 
# What is the time complexity?

def linear_search(list)
    target=list[0] 
    list.each{|ele| target=ele if ele < target}
    return target
end

list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
p linear_search(list)  # =>  -5

# time complexity is O(n)

randomArray=(1..10000).to_a.shuffle

Benchmark.bmbm do |x|
    x.report("bubblesearch") { bubble_search_why?(list) }
    x.report("linearsearch"){linear_search(list)}
    x.report("min"){list.min}

    x.report("bubblesearch on random"){bubble_search_why?(randomArray)}
    x.report("linearsearch random"){linear_search(randomArray)}
    x.report("min random"){randomArray.min}


  end