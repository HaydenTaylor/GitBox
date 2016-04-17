class Array
  def my_inject(accumulator = nil, &prc)
    skip = false
    if accumulator.nil?
      accumulator = self.first
      skip = true
    end
    prc ||= Proc.new {|accum, el| accum + el}
    self.each do |el|
      if skip == true
        skip = false
        next
      end
      accumulator = prc.call(accumulator, el)
    end
    accumulator
  end
end

def is_prime?(num)
  (2...num).any? {|factor| num % factor == 0} ? false : true
end

def primes(count)
  pr = []
  n = 2
  until pr.length == count
    pr << n if is_prime?(n)
    n += 1
  end
  pr
end

# the "calls itself recursively" spec may say that there is no method
# named "and_call_original" if you are using an older version of
# rspec. You may ignore this failure.
# Also, be aware that the first factorial number is 0!, which is defined
# to equal 1. So the 2nd factorial is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
  return [1] if num == 1
  return [1, 1] if num == 2
  facts = []
  until facts.length == num
    prev_facts = factorials_rec(num-1)
    facts = (prev_facts << prev_facts.last  * (num-1))
  end
  facts
end

class Array
  def dups
    locations = Hash.new {|h,k| h[k] = []}
    self.each_with_index {|value, i| locations[value] << i}
    locations.select {|_, indices| indices.length > 1}
  end
end

class String

  def substrings(string)
    subs = []
    start = 0
    while start < string.length
      stop = start + 1
      while stop < string.length
        subs << string[start..stop]
        stop += 1
      end
      start += 1
    end
    subs
  end


  def symmetric_substrings
    subs = substrings(self)
    subs.select{|s| s == s.reverse}.uniq

  end
end

class Array
  def merge_sort(&prc)
    prc ||= Proc.new {|a,b| a <=> b}
    return self if self.length < 2
    Array.merge(
                self.take(self.length/2).merge_sort(&prc),
                self.drop(self.length/2).merge_sort(&prc),
                 &prc)
  end

  private
  def self.merge(left, right, &prc)
    merged = []
    until left.empty? || right.empty?
      prc.call(left[0], right[0]) == -1 ? merged << left.shift : merged << right.shift
    end
    merged + left + right
  end
end
