require 'byebug'

class Array
  def my_inject(accumulator = nil, &prc)
    # prc ||= Proc.new {|accum, el| }
    # default Proc
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
  num > 1 ? (2..num-1).all? {|x| num % x != 0} : false
end

def primes(count)
  return [] if count == 0 # DON'T MESS UP = WITH ==
  primes = []
  checking = 2
  until primes.length == count
    # debugger if count > 0
    primes << checking if is_prime?(checking)
    checking += 1
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
  return [1,1] if num == 2
  facts = []
  until facts.length == num
    facts = factorials_rec(num - 1)
    facts << facts.last * (num - 1)
  end
  facts
end

class Array

end

class String

  def substrings
    start = 0
    subs = []
    while start < self.length - 1
      stop = start + 1
      while stop < self.length
        subs << self[start..stop]
        stop += 1
      end
      start += 1
    end
    subs
  end


  def symmetric_substrings
    subs = self.substrings
    subs.select {|x| x == x.reverse}

  end
end

class Array
  def merge_sort(&prc)

  end

  private
  def self.merge(left, right, &prc)

  end
end
