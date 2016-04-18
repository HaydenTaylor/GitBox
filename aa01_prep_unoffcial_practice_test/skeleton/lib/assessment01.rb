require 'byebug'
#ALWAYS WORK ON THE RIGHT PROBLEM! CHECK OFTEN!
# << nests, but += will concat arrays

def exponentiate(base, power)
  return 1 if power == 0
  return (exponentiate(base, power - 1)) * base

end

class Array

  def my_rotate(rotations = 1)
    shift = rotations % self.length
    new_arr = self.drop(shift) + self.take(shift)

  end

  def my_flatten
    # return self if self.class != Array
    return self if self.class != Array
    flat = []
    self.each do |el|
      if el.class != Array
        flat << el
      else
        flat += el.my_flatten
      end
    end
    # until flat.all? {|x| x.class != Array}
    #   flat.my_flatten
    # end
    flat
  end



  #   self.map do |el|
  #     if el.class != Array
  #       return self
  #     else
  #       return *self
  #     end
  #
  #   end
  #
  # end

end

def subwords(word, dictionary)
  def subsets(word)
    subs = []
    start = 0
    while start < word.length
      stop = start
      while stop < word.length
        subs << word[start..stop]
        stop += 1
      end
      start += 1
    end
    subs
  end

  subsets(word).uniq.select {|word| dictionary.include?(word)}



end

class Array
  def merge_sort(&prc)
    return self if self.length < 2
    prc ||= Proc.new {|x,y| x <=> y}
    left = self.take(self.length/2)
    right = self.drop(self.length/2)
    Array.merge(left.merge_sort(&prc), right.merge_sort(&prc), &prc)
  end

  private
  def self.merge(left, right, &prc)
    merged = []
    until left.empty? || right.empty?
      prc.call(left.first, right.first) < 0 ? merged << left.shift : merged << right.shift
    end
    merged + left + right
  end

end

class Array
  def quick_sort(&prc)
    # debugger
    return self if self.length < 2
    prc ||= Proc.new {|x,y| x <=> y}
    pivot = self[self.length/2]
    left = []
    right = []
    self.each do |el|
      # debugger
      prc.call(el, pivot) < 1 ? left << el : right << el
    end
    left.quick_sort(&prc) + right.quick_sort(&prc)
  end
end
#I CAN'T FIGURE OUT WHY THIS GOES STACK OVERFLOW
#but also, remember to NOT INCLUDE THE PIVOT in left or right

# You're almost done! Keep it up!
def subsets(arr)
  # debugger
  return [[]] if arr.length < 1
  subs = subsets(arr[0...-1])
  subs += subs.map{|set| set += [arr.last]}
  subs
end

#read carefully - PASS ARGUMENT, or act on SELF??
# don't say + when you want +=
#revise base cases after refactoring. CHECK OLD STUFF AFTER LOTS OF CHANGES to
# make sure the original code still makes sense with the changes
