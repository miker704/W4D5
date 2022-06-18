# require 'byebug'
require 'benchmark'

# Anagrams
# Our goal today is to write a method that determines if
#  two given words are anagrams. This means that the letters
#   in one word can be rearranged to form the other word. 
#   For example:

# anagram?("gizmo", "sally")    #=> false
# anagram?("elvis", "lives")    #=> true
# Assume that there is no whitespace or punctuation in the given strings.


# Learning Goals
# Be able to determine the time and space complexity of a method
# Be able to recognize when and how time or space complexity can be improved
# Be able to compare different methods and discuss how 
# changing inputs affects each one's overall runtime
# Phase I:
# Write a method #first_anagram? that will generate and store all the possible anagrams of 
# the first string. Check if the second string is one of these.


# WIP first try

# def first_anagram?(string_1,string_2)
#     s1 = string_1.split("") #["a", "b", "c"]
#     perm_s1 = []
#     s2 = s1[1..-1]  
#     letter = s1.first
# debugger
#     (1...string_1.length-1).each do |i| #i =1
#         s2.insert(i,letter) # "b + a + c"
#         # letter = s2[i]
#         perm_s1 << s2
#         end
# perm_s1 + [string_1.split("")]
# end

def first_anagram?(string_1,string_2)
    s1 = string_1.split("") 
    arr = []

    (0...s1.length-1).each do |i|
        s1[i], s1[i+1] = s1[i+1], s1[i]
        arr << s1 
    end

return arr


end



p first_anagram?("abc", "sally")

def perm_str(str)
    s1 = str.split("")
    perm_str = []
    n=str.length

    n.times do 
        perm_str<< s1.push(s1.shift).join("")
    end
return perm_str.uniq
end

# n.times do |i|
# cut=i%s1.length
# perm_str<<(s1.drop(cut)+s1.take(cut)).join("")
# end

# p perm_str("gizmo")

# anagram?("gizmo", "sally")    #=> false
# anagram?("elvis", "lives")    #=> true

# Hints:

# For testing your method, start with small input strings, otherwise you might wait a while
# If you're having trouble generating the possible anagrams, look into this method.
# What is the time complexity of this solution? What happens if you increase the size of the strings?

# Phase II:
# Write a method #second_anagram? that iterates over the first string. 
# For each letter in the first string, find the index of that letter in the second string 
# (hint: use Array#find_index) and delete at that index. The two strings are anagrams if an index is
#  found for every letter and the second string is empty at the end of the iteration.

def anagrams_phase_2(str1,str2)
    str1=str1.split("") # space n 1 , speed 1
    str2=str2.split("") # space n 1 , speed 1

    str1.each do |i|

        index_check = str2.index(i)   # space 1, speed 1
        return false if index_check.nil? # speed 1
        str2.delete_at(index_check) # speed 1
    
    end
    return str2.empty? # speed 1
end

# O(n) space O(n^2) speed/time because the delete at function uses a loop to get to the index to delete/ find at function
# Array#find_index function uses a loop to get to said index 
p anagrams_phase_2("gizmo", "sally")    #=> false
p anagrams_phase_2("elvis", "lives")    #=> true


# Try varying the length of the input strings. What are the differences between #first_anagram? 
# and #second_anagram??

# Phase III:
# Write a method #third_anagram? that solves the problem by sorting both strings alphabetically.
#  The strings are then anagrams if and only if the sorted versions are identical.

# What is the time complexity of this solution? Is it better or worse than #second_anagram??


def anagrams_phase_3(str1,str2)
    # using casecmp to sort the strings this ignores the case status of the chars
    sorted_str1=str1.split("").sort # the algorthim is currently at this point O(n log n) 
    sorted_str2=str2.split("").sort #line 101 and 102 == 1+1+1+1+ O(n log n) * 2
    # why?  ruby.sort is a built in algo that uses quick sort but with <=> for faster sorting 
    #however despite sorting faster than a tradtional immplementation of quick sort it is not fast enough
    # to break past the O(n log n) speeds
    
    return sorted_str1==sorted_str2
end
#speed is O(n log n) space is O(n)
p anagrams_phase_3("gizmo", "sally")    #=> false
p  anagrams_phase_3("elvis", "lives")    #=> true

# Phase IV:
# Write one more method #fourth_anagram?. This time, use two hashes to store the 
# number of times each letter appears in both words. Compare the resulting hashes.

# What is the time complexity?

# Bonus: Do it with only one hash.

# Discuss the time complexity of your solutions together, then call over your TA to look at them.


def anagrams_phase_4(str1,str2)
    return hashit(str1)==hashit(str2) # 1 for comparsion 3 for calling the functions and comparing
end

def hashit(str1)
    hash=Hash.new(0) # 1 speed 1 space
    str1.each_char{|char|hash[char]+=1} # speed =  1 for loop 1 for insert to hash and 1 for look up in hash
    # 3
    return hash # 1
end

def anagrams_phase_4_no_external_function(str1,str2)
    hash1=Hash.new(0)
    hash2=Hash.new(0)
    str1.each_char{|char|hash1[char]+=1}
    str2.each_char{|char|hash2[char]+=1}

    return hash1==hash2
end

def anagrams_phase_4_one_hash(str1,str2)
    hash=Hash.new(0)
    str1.each_char{|char|hash[char]+=1}
    str2.each_char{|char|hash[char]-=1}
    return hash.each_value.all?{|val| val==0}
end

# p anagrams_phase_4("gizmo", "sally")    #=> false
# p anagrams_phase_4("elvis", "lives")    #=> true
# this utilizez O(n) speed and 0(1) space 



Benchmark.bmbm do |x|
  
    # x.report("anagrams_phase_1(gizmo,sally)") { anagrams_phase_1("gizmo", "sally") }
    # x.report("anagrams_phase_1(elvis, lives)") { anagrams_phase_1("elvis", "lives") }

    x.report("anagrams_phase_2(gizmo,sally)") { anagrams_phase_2("gizmo", "sally") }
    x.report("anagrams_phase_2(elvis, lives)") { anagrams_phase_2("elvis", "lives") }

    x.report("anagrams_phase_3(gizmo,sally)") { anagrams_phase_3("gizmo", "sally") }
    x.report("anagrams_phase_3(elvis, lives)") { anagrams_phase_3("elvis", "lives") }

    x.report("anagrams_phase_4(gizmo,sally)") { anagrams_phase_4("gizmo", "sally") }
    x.report("anagrams_phase_4(elvis, lives)") { anagrams_phase_4("elvis", "lives")}
    x.report("anagrams_phase_4_no_external(gizmo,sally)") { anagrams_phase_4_no_external_function("gizmo", "sally") }
    x.report("anagrams_phase_4_no_external(elvis, lives)") { anagrams_phase_4_no_external_function("elvis", "lives")}
    x.report("anagrams_phase_4_one_hash(gizmo,sally)") { anagrams_phase_4_one_hash("gizmo", "sally") }
    x.report("anagrams_phase_4_one_hash(elvis, lives)") { anagrams_phase_4_one_hash("elvis", "lives")}

   
  end

