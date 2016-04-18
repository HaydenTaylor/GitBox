# DISCLAIMER: Some of these solutions are student solutions. So they might actually be terrible.

def greatest_exponent_under_decimal(decimal)
  exponent = 0
  power_product = 2 ** exponent

  until power_product > decimal
    exponent += 1
    power_product *= 2
  end

  exponent -= 1

  exponent
end

def to_binary(decimal)
  # debugger
  return "0" if decimal == 0
  exponent = greatest_exponent_under_decimal(decimal)
  binary = "1"
  decimal -= 2 ** exponent
  exponent -= 1

  until exponent < 0
    power_product = 2 ** exponent
    if decimal >= power_product
      decimal -= power_product
      binary << "1"
    else
      binary << "0"
    end
    exponent -= 1
  end
  binary
end

# Brute force version
def exponentiate1(base, power)
  return 1 if power == 0
  base * exponentiate1(base, power - 1)
end

#Elegant version
def exponentiate2(base, power)
  return 1 if power == 0
  return base if power == 1
  if power % 2 == 0
    exponentiate2(base, power / 2) ** 2
  else
    base * exponentiate2(base, (power - 1) / 2) ** 2
  end
end

class Array
  def my_each(&prc)
    idx = 0

    until idx == self.length
      prc.call(self[idx])
      idx += 1
    end

    self
  end

  def my_inject(accumulator = nil, &block)
    i = 0

    if accumulator.nil?
      accumulator = self.first
      i += 1
    end

    while i < length
      accumulator = block.call(accumulator, self[i])
      i += 1
    end

    accumulator
  end

  def my_map(&prc)
    idx = 0
    arr = []

    while idx < self.length
      arr << prc.call(self[idx])
      idx += 1
    end

    arr
  end

  def my_select(&prc)
    idx = 0
    arr = []

    until idx == length
      arr << self[idx] if prc.call(self[idx])
      idx += 1
    end

    arr
  end

  def my_reject(&prc)
    idx = 0
    arr = []

    while idx < self.length
      arr << self[idx] unless prc.call(self[idx])
      idx += 1
    end

    arr
  end

  def my_all?(&prc)
    idx = 0

    while idx < self.length
      return false unless prc.call(self[idx])
      idx += 1
    end

    true
  end

  def my_none?(&prc)
    idx = 0

    while idx < self.length
      return false if prc.call(self[idx])
      idx += 1
    end

    true
  end

  def my_any?(&prc)
    idx = 0

    while idx < self.length
      return true if prc.call(self[idx])
      idx += 1
    end

    false

  end

  def my_join(separator)
    idx = 0
    join = ""

    while idx < self.length
      join += self[idx]
      join += separator
      idx += 1
    end

    join.slice(0, join.length - separator.length)
  end

  def my_rotate(rotations = 1)
    rotations = rotations % length
    drop(rotations) + take(rotations)
  end

  def my_zip(*arg_arrays)
    arr = (0...length).to_a

    arr.map do |global_idx|
      spot = [self[global_idx]]

      arg_arrays.each do |arg_arr|
        spot << arg_arr[global_idx]
      end

      spot
    end
  end

  def my_flatten
    return self if self.none? { |el| el.is_a?(Array) }
    flattened_arr = []
    self.each do |el|
      if el.is_a?(Array)
        flattened_arr += el
      else
        flattened_arr += [el]
      end
    end
    flattened_arr.my_flatten
  end

  def bubble_sort!(&prc)
    prc ||= Proc.new { |x, y| x <=> y }


    (length - 1).times do
    i = 0
      while i < self.length - 1
        case prc.call(self[i], self[i + 1])
        when 1
          self[i], self[i + 1] = self[i + 1], self[i]
        end
        i += 1
      end
    end
    self
  end

  def bubble_sort(&prc)
    prc ||= Proc.new { |x, y| x <=> y }

    self.dup.bubble_sort!(&prc)
  end
end

def is_prime?(num)
  (2...num).none? { |factor| num % factor == 0 }
end

def primes(count)
  primes = []

  i = 2
  until primes.count >= count
    primes << i if is_prime?(i)

    i += 1
  end

  primes
end

def factorial(num)
  return nil if num < 0
  return 1 if num == 0
  num * factorial(num - 1)
end

def factorials(num)
  if num == 1
    [1]
  else
    facs = factorials(num - 1)
    facs << facs.last * (num - 1)
    facs
  end
end

class Array
  def dups
    positions = Hash.new { |h, k| h[k] = [] }

    each_with_index do |item, index|
      positions[item] << index
    end

    positions.select { |key, val| val.count > 1 }
  end
end

class String
  def symmetric_substrings
    symm_subs = []

    length.times do |start_pos|
      (2..(length - start_pos)).each do |len|
        substr = self[start_pos...(start_pos + len)]
        symm_subs << substr if substr == substr.reverse
      end
    end

    symm_subs
  end

  def palindrome?
    return true if length <= 1
    self[0] == self[-1] && self[1..-2].palindrome?
  end
end

def doubler(arr)
  arr.map { |num| num * 2 }
end

def subwords(word, dictionary)
  subwords = []
  i = 0
  j = 0

  while i < word.length - 1
    while j < word.length
      subword = word[i..j]
      subwords << subword if dictionary.include?(subword)
      j += 1
    end
    i += 1
    j = i
  end
  subwords.uniq
end

def factors(num)
  (1..num).to_a.select { |divisor| num % divisor == 0 }
end

class Array
  def merge_sort(&prc)
    # See how I create a Proc if no block was given; this eliminates
    # having to later have two branches of logic, one for a block and
    # one for no block.
    prc ||= Proc.new { |x, y| x <=> y }

    return self if count <= 1

    Array.merge(
      self.take(count / 2).merge_sort(&prc),
      self.drop(count / 2).merge_sort(&prc),
      &prc
    )
  end

  private
  def self.merge(left, right, &prc)
    merged = []

    until left.empty? || right.empty?
      case prc.call(left.first, right.first)
      when -1
        merged << left.shift
      when 0
        merged << left.shift
      when 1
        merged << right.shift
      end
    end

    merged.concat(left)
    merged.concat(right)

    merged
  end
end

class Array
  def quick_sort(&prc)
    arr = []
    self.each do |el|
      arr << el
    end
    prc ||= Proc.new { |x, y| x <=> y }

    return [] if arr.empty?
    return arr if arr.length == 1

    index = arr.length / 2
    pivot = arr.delete_at(index)

    left = arr.select do |el|
      prc.call(pivot, el) >= 0
    end

    right = arr.select do |el|
      prc.call(pivot, el) <= 0
    end

    left.quick_sort(&prc) + [pivot] + right.quick_sort(&prc)
  end
end

# Not sure what the proper programming notation for an infinitely long aliquot
# sequence is, so don't worry about accounting for the sequence of 6, for example (?)
def aliquot_sequence(num)
 return [0] if num == 0
 return [1, 0] if num == 1
 [num] + aliquot_sequence(aliquot(num))
end

def aliquot(num)
 factors_sum = 0

 (1...num).each do |i|
   factors_sum += i if num % i == 0
 end

 factors_sum
end

class Array
  # NB: Binary search works only on sorted arrays. Return an index.
  # NB: Return nil if the target is not found in the array.
  def binary_search(target)
    idx = length / 2
    return nil if self.empty?
    return idx if self[idx] == target
    if target > self[idx]
      next_search =
      self[idx + 1..-1].binary_search(target).nil? ? nil : next_search + idx + 1
    elsif target < self[idx]
      self[0...idx].binary_search(target)
    end
  end
end

#Problem 1: You have array of integers. Write a recursive solution to find the
#sum of the integers.

def sum(array)
  return 0 if array.empty?
  sum(array.drop(1)) + array.first
end

#Problem 2: You have array of integers. Write a recursive solution to determine
#whether or not the array contains a specific value.

def my_include?(array, target)
  return false if array.empty?
  return true if array.first == target
  my_include?(array.drop(1), target)
end

# Recursive solution.
# By the way, this is a terrible method. It creates as many stack levels as
# the array is long. Maybe someone will write a better one.
# You might even consider just not even doing this one for practice.
class Array
  def my_uniq?
    return true if length <= 1
    idx = 1
    while idx < length
      return false if first == self[idx]
      idx += 1
    end
    self.drop(1).my_uniq?
  end
end

# Problem 3: You have an unsorted array of integers. Write a recursive solution
# to count the number of occurrences of a specific value.

def num_occur(array, target)
  return 0 if array.empty?
  count_update = array.first == target ? 1 : 0
  count_update + num_occur(array.drop(1), target)
end

# Problem 4: You have array of integers. Write a recursive solution to determine
# whether or not two adjacent elements of the array add to 12.

def add_to_twelve?(array)
  return false if array.length <= 1
  return true if array[0] + array[1] == 12
  add_to_twelve?(array.drop(1))
end

# Problem 5: You have array of integers. Write a recursive solution to determine
# if the array is sorted.

def sorted?(array)
  return true if array.length <= 1
  return false if array[0] > array[1]
  sorted?(array.drop(1))
end

# Problem 6: Write a recursive function to reverse a string. Don't use any
# built-in #reverse methods!

def reverse(string)
  return string if string.length <= 1
  string[-1] + reverse(string.slice(1, string.length - 2)) + string[0]
end

# Student solution
def subsets(arr)
  return [[]] if arr.empty?
  return [[], [arr.first]] if arr.length == 1
  smaller_arr_subsets = subsets(arr[0..-2])
  smaller_arr_subsets + smaller_arr_subsets.map { |set| set + [arr.last]}
end
