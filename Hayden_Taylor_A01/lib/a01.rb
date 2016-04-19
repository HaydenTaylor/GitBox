require 'byebug'

class Array
  # Write an Array method that returns a bubble-sorted copy of an array
  def bubble_sort(&prc)
    self.dup.bubble_sort!(&prc)

  end

  # You are not required to implement this; it's here as a suggestion :-)
  def bubble_sort!(&prc)
    prc ||= Proc.new {|x,y| x <=> y}
    sorted = false
    until sorted
      sorted = true
      i = 0
      while i < self.length - 1 #changed 2 to 1
        if prc.call(self[i], self[i+1]) > 0
          self[i], self[i+1] = self[i+1], self[i]
          sorted = false
        end
        i += 1
      end
    end
    return self
  end


end

class Array
  # Write a new `Array#pair_sum(target)` method that finds all pairs of
  # positions where the elements at those positions sum to the target.

  # NB: ordering matters. I want each of the pairs to be sorted
  # smaller index before bigger index. I want the array of pairs to be
  # sorted "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

  def pair_sum(target)
    first = 0
    pairs = []
    while first < self.length - 2
      # debugger
      second = first + 1
      while second < self.length
        pairs << [first, second] if self[first] + self[second] == target
        #simple mistake. I had:
        #pairs << [first, second] if first + second == target
        #should have named them like first_idx. assumed it was the element itself, not the idx.
        second += 1
      end
      first += 1
    end

    pairs
  end



end

class Array
  # Write a method that flattens an array to the specified level. If no level
  # is specified, it should entirely flatten nested arrays.

  # Examples:
  # Without an argument:
  # [["a"], "b", ["c", "d", ["e"]]].my_flatten = ["a", "b", "c", "d", "e"]

  # When given 1 as an argument:
  # (Flattens the first level of nexted arrays but no deeper)
  # [["a"], "b", ["c", "d", ["e"]]].my_flatten(1) = ["a", "b", "c", "d", ["e"]]

  def my_flatten(level = nil, call_number = 1)
    # debugger
    p "level: #{level}  call_number: #{call_number}"
    return self if self.class != Array || level == 0
    flattened_array = []
    self.each do |x|
      if x.is_a?(Array)
        p "82 array check"
        if level.nil? || call_number <= level
          p "self: #{self} 84 > recursive with level: #{level}; call_number: #{call_number}"
          flattened_array += x.my_flatten(level, call_number + 1)
        else
          flattened_array << x
          p " 88 adding array: level achieved."
          p "self: #{self} level: #{level}; call_number: #{call_number}"
          p x
          p flattened_array
        end
      else
        p " 91 x is NOT array"
        flattened_array << x
      end
    end
    flattened_array
  end
end

class String
  # This method returns true if the sentence passed as an argument
  # can be created by rearranging the receiving string.

  # Example:
  # "cats are cool".shuffled_sentence_detector("dogs are cool") => false
  # "cats are cool".shuffled_sentence_detector("cool cats are") => true

  def shuffled_sentence_detector(other)
    original_words = self.split(" ")
    other_words = other.split(" ")
    original_words.sort == other_words.sort
  end
end

def prime?(num)
  return false if num < 2
  return true if num == 2
  return false if (2..num-1).any? {|factor| num % factor == 0}
  true
end

# Write a method that sums the first n prime numbers starting with 2.
def sum_n_primes(n)
  return 0 if n == 0
  sum = 0
  primes = []
  i = 2
  until primes.length == n
    #
    if prime?(i)
      sum += i
      primes << i #corrected primes counting. was adding i each time before
    end
    i += 1
  end
  sum
end

class Array
  # Write a method that calls a passed block for each element of the array
  def my_each
    i = 0
    while i < self.length
      yield self[i]
      i += 1
    end
    return self
  end


end

class Array

    def my_inject(accumulator = nil, &prc)
      skip_one = false
      if accumulator.nil?
        skip_one = true
        accumulator = self[0]
      end

      self.each do |el|
        # debugger
        if skip_one == true
          skip_one = false
          next
        end
        accumulator = prc.call(accumulator, el)
        # my whole error was this: += instead of = above. assumptions, habits.
      end

    accumulator
  end

end
