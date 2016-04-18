#practice test try 3

require 'byebug'
class Array
  def my_inject(accumulator = nil, &prc)
    skip_one = false
    if accumulator.nil?
      accumulator = self.first
      skip_one = true
    end

    self.each do |el|
      if skip_one
        skip_one = false
        next
      end
      accumulator = prc.call(accumulator, el)
    end
    accumulator
  end

end

def is_prime?(num)
  # 0, 1 = false; 2 = true
  return false if num < 2
  (2..num - 1).all? {|factor| num % factor != 0}

end

def primes(count)
  return [] if count == 0
  primes = []
  n = 2
  until primes.length == count
    primes << n if is_prime?(n)
    n += 1
  end
  primes

end






# the "calls itself recursively" spec may say that there is no method
# named "and_call_original" if you are using an older version of
# rspec. You may ignore this failure.
# Also, be aware that the first factorial number is 0!, which is defined
# to equal 1. So the 2nd factorial is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
  return [1] if num == 1
  # debugger
  facts = factorials_rec(num - 1)
  facts << facts.last * (num - 1)
  facts

end


class Array

  def dups
    locations = Hash.new {|h,k| h[k] = []}
    self.each_with_index do |value, i|
      locations[value] << i
    end

    locations.select{|_, indices| indices.length > 1}

  end

end


class String

  def substrings(string)
    subs = []
    start = 0
    until start == string.length - 1
      stop = start + 1
      until stop == string.length
        subs << string[start..stop]
        stop += 1
      end
      start += 1
    end
    subs

  end


  def symmetric_substrings
    subs = substrings(self)
    subs.select {|part| part == part.reverse}
  end

end




class Array
  def merge_sort(&prc)
    prc ||= Proc.new {|x,y| x <=> y}
    return self if self.length < 2
    left = self.take(self.length/2)
    right = self.drop(self.length/2)
    Array.merge(left.merge_sort(&prc), right.merge_sort(&prc), &prc)

  end

  private
  def self.merge(left, right, &prc)
    merged = []
    until left.empty? || right.empty?
      prc.call(left.first, right.first) < 1 ? merged << left.shift : merged << right.shift
    end
    merged + left + right
  end
end
