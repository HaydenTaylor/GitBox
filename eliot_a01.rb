require 'byebug'

# This is an alternate version of the a01 practice assessment for practice
# purposes. Hopefully representing the kinds of problems we are likely to
# encounter in the real thing.

# create my_reject, this should accept a block.
def my_reject(arr,&prc)
  remainders = []
  arr.each {|el| remainders << el if prc.call(el)}
  remainders
end

# monkey patch my_all? and my_zip into the Array class.
class Array
  def my_all?(&prc)
    self.each do |el|
      return false unless prc.call(el)
    end
    true
  end

  def my_zip(*args)
    zip = []
    self.each_with_index do |self_el, i|
      sub_array = [self_el]
      args.each do |arg|
        sub_array << arg[i]
      end
      zip << sub_array
    end
    zip
  end


end

# create a recursive method to check if a string is a palindrome.
def palindrome?(string)
  return true if string.length == 1
  return true if string.length == 2 && string[0] == string[1]
  return true if string[0] == string[string.length-1] && palindrome?(string[1...-1])
  false
end

# create a binary search method that first calls a quicksort method, then
# finds a target element. Quicksort should take an optional block.

def bsearch(arr, target, sorted = false)
  debugger
  if arr.length == 1
    arr == target ? (return arr) : (return nil)
  end
  arr = arr.quicksort unless sorted
  search = arr[arr.length/2]
  case search <=> target
  when -1
      return bsearch(arr[0...search], target, true)
  when 0
    return true
  when 1
    return bsearch(arr[search + 1] , target, true)
  end


end

class Array
  def quicksort(&prc)
    return self if self.length < 2
    prc ||= Proc.new {|x,y| x <=> y }
    pivot = self[self.length/2]
    left = self.select {|el| prc.call(el, pivot) == -1}
    right = self.select {|el| prc.call(el, pivot) == 1}
    left.quicksort(&prc) + [pivot] + right.quicksort(&prc)
  end

  def subsets
    # debugger
    return [[]] if self.empty?
    subs = self[0...-1].subsets
    subs += subs.map {|x| x + [self.last]}
    subs
  end
end

#things you CAN'T DO ABOVE:
# -    subs += subs.map {|x| x << self.last}
# because << mutates the original array. So all the sub-arrays in subs are being
# changed, even though you just want to use their values.
# -   subs += subs.dup.map {|x| x + self.last}
# Still won't work, because dup is NOT DEEP DUP, so all those subarrays
# are not duped, and will still be mutated by the <<
# So the only thing I got to work was this above, just use +, and bracket the
# added element so you can ensure that it goes into the array properly.



# patch the String class with substring_count which will take a target and
# return an array containing the number of times that substring uniquely
# appears and another array of the indices at which the substring starts.

# example: 'hello there'.substring_count('he') => [2, [0, 7]]
class String
  def substring_count(substring)
    starting_idx = 0
    indices = []
    while starting_idx < self.length
      if self[starting_idx...(starting_idx + substring.length)] == substring
        indices << starting_idx
      end
      debugger
      starting_idx += 1
    end
    [indices.count, indices]
  end

  def substrings
    subs = []
    start = 0
    while start < self.length
      stop = start
        while stop < self.length
          subs << self[start..stop]
          stop += 1
        end
      start += 1
    end
    subs
  end

end
