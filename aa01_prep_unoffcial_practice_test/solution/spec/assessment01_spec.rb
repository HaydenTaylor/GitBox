require 'rspec'
require 'spec_helper'
require 'assessment01'

describe "#to_binary" do
  # `primes(num)` returns an array of the first `num` primes

  it "gives the binary of 0" do
    expect(to_binary(0)).to eq("0")
  end

  it "gives the binary of 15" do
    expect(to_binary(15)).to eq("1111")
  end

  it "gives the binary of 2000" do
    expect(to_binary(2000)).to eq("11111010000")
  end
end

describe "#exponentiate1" do
  it "raises a number to a power" do
    expect(exponentiate1(2, 5)).to eq(32)
  end

  it "raises a number to the power of zero" do
    expect(exponentiate1(243, 0)).to eq(1)
  end
end

describe "#exponentiate2" do
  it "raises a number to a power" do
    expect(exponentiate2(2, 5)).to eq(32)
  end

  it "raises a number to the power of zero" do
    expect(exponentiate2(243, 0)).to eq(1)
  end
end

describe "#primes" do
  # `primes(num)` returns an array of the first `num` primes

  it "returns first five primes in order" do
    expect(primes(5)).to eq([2, 3, 5, 7, 11])
  end

  it "returns an empty array when asked for zero primes" do
    expect(primes(0)).to eq([])
  end
end

describe "#factorial" do
  it "returns the factorial of zero" do
    expect(factorial(0)).to eq(1)
  end

  it "returns the factorial of two" do
    expect(factorial(10)).to eq(3628800)
  end

  it "returns nil for a negative factorial" do
    expect(factorial(-2)).to be_nil
  end
end

describe "#factorials" do
  # Write a **recursive** implementation of a method that returns the
  # first `n` factorial numbers.
  # Be aware that the first factorial number is 0!, which is defined to
  # equal 1. So the 2nd factorial is 1!, the 3rd factorial is 2!, etc.

  it "returns first factorial number" do
    expect(factorials(1)).to eq([1])
  end

  it "returns first two factorial numbers" do
    expect(factorials(2)).to eq([1, 1]) # = [0!, 1!]
  end

  it "returns many factorials numbers" do
    expect(factorials(6)).to eq([1, 1, 2, 6, 24, 120])
    # == [0!, 1!, 2!, 3!, 4!, 5!]
  end

  it "calls itself recursively" do
    # this should enforce you calling your method recursively.

    expect(self).to receive(:factorials).at_least(:twice).and_call_original
    factorials(6)
  end
end

describe "#my_select" do
  let(:array) { [1, 2, 3, 4, 5] }

  it "returns an empty array where appropriate when called on an empty array" do
    expect([].my_select { |el| el.even? }).to eq([])
  end

  it "returns an empty array when nothing passes the block" do
    expect(array.my_select { |num| num < 0 }).to eq([])
  end

  it "returns an array of elements passing the block" do
    expect(array.my_select { |num| num.odd? }).to eq([1, 3, 5])
  end

  it "does not modify original" do
    duped_array = array.dup
    duped_array.my_select { |el| puts el }
    expect(duped_array).to eq(array)
  end
end

describe "#my_reject" do
  let(:array) { [1, 2, 3, 4, 5] }

  it "returns an empty array where appropriate when called on an empty array" do
    expect([].my_select { |el| el.even? }).to eq([])
  end

  it "returns an empty array when nothing passes the block" do
    expect(array.my_select { |num| num < 0 }).to eq([])
  end

  it "returns an array of elements passing the block" do
    expect(array.my_select { |num| num.odd? }).to eq([1, 3, 5])
  end

  it "does not modify original" do
    duped_array = array.dup
    duped_array.my_select { |el| puts el }
    expect(duped_array).to eq(array)
  end
end

describe 'Array#my_inject' do
  # Monkey patch the Array class and add my_inject method Be aware that
  # if the default accumulator is not passed then the first element of
  # the array is used as the accumulator.

  it 'calls the block passed to it' do
    expect do |block|
      ["test array"].my_inject(:dummy, &block)
    end.to yield_control.once
  end

  it 'makes the first element the accumulator if no default is given' do
    expect do |block|
      ["el1", "el2", "el3"].my_inject(&block)
    end.to yield_successive_args(["el1", "el2"], [nil, "el3"])
  end

  it 'yields the accumulator and each element to the block' do
    expect do |block|
      [1, 2, 3].my_inject(100, &block)
    end.to yield_successive_args([100, 1], [nil, 2], [nil, 3])
  end

  it 'does NOT call the built in Array#inject method' do
    original_array = ["original array"]
    expect(original_array).not_to receive(:inject)
    original_array.my_inject {}
  end

  it 'with accumulator, it correctly injects and returns answer' do
    expect([1, 2, 3].my_inject(1) { |acc, x| acc + x }).to eq(7)
    expect([3, 3].my_inject(3) { |acc, x| acc * x }).to eq(27)
  end

  it 'without accumulator, it correctly injects and returns answer' do
    expect([1, 2, 3].my_inject { |acc, x| acc + x }).to eq(6)
    expect([3, 3].my_inject { |acc, x| acc * x }).to eq(9)
  end
end

describe "#dups" do
  # Write a new Array method (using monkey-patching) that will return
  # the location of all identical elements. The keys are the
  # duplicated elements, and the values are arrays of their positions,
  # sorted lowest to highest.

  it "solves a simple example" do
    expect([1, 3, 0, 1].dups).to eq({ 1 => [0, 3] })
  end

  it "finds two dups" do
    expect([1, 3, 0, 3, 1].dups).to eq({ 1 => [0, 4], 3 => [1, 3] })
  end

  it "finds multi-dups" do
    expect([1, 3, 4, 3, 0, 3].dups).to eq({ 3 => [1, 3, 5] })
  end

  it "returns {} when no dups found" do
    expect([1, 3, 4, 5].dups).to eq({})
  end
end

describe "#symmetric_substrings" do
  # Write a `String#symmetric_substrings` method that takes a returns
  # substrings which are equal to their reverse image ("abba" ==
  # "abba"). We should only include substrings of length > 1.

  it "handles a simple example" do
    expect("aba".symmetric_substrings).to match_array(["aba"])
  end

  it "handles two substrings" do
    expect("aba1cdc".symmetric_substrings).to match_array(["aba", "cdc"])
  end

  it "handles nested substrings" do
    expect("xabax".symmetric_substrings).to match_array(["aba", "xabax"])
  end
end

describe "String#palindrome?" do
  it "returns true for a single letter" do
    expect("a".palindrome?).to be_truthy
  end

  it "returns true for a longer palindrome" do
    expect("racecar".palindrome?).to be_truthy
  end

  it "returns false for a non-palindrome" do
    expect("apple".palindrome?).to be_falsey
  end
end

describe Array do
  let (:array1) { [*'a'..'c'] }
  let (:array2) { [*1..3] }
  let (:array3) { [*4..6] }
  let (:array4) { [*7..10] }
  let (:array5) { [100] }

  describe "#my_rotate" do
    it "rotates in the normal direction one time with a default argument" do
      expect([1, 2, 3].my_rotate).to eq([2, 3, 1])
    end

    it "rotates in the opposite direction one time" do
      expect([1, 2, 3].my_rotate(-1)).to eq([3, 1, 2])
    end

    it "rotates, like, a bajillion times" do
      expect([1, 2, 3].my_rotate(300)).to eq([1, 2, 3])
    end
  end

  describe "#my_zip" do
    it "returns a zipped array with one argument when all arrays are of the same length" do
      expect(array1.zip(array2)).to eq([
                                    ['a', 1],
                                    ['b', 2],
                                    ['c', 3]
                                  ])
    end

    it "returns a zipped array with one argument when all arrays are of the same length" do
      expect(array1.zip(array2, array3)).to eq([
                                    ['a', 1, 4],
                                    ['b', 2, 5],
                                    ['c', 3, 6]
                                  ])
    end

    it "truncates an argument array of greater length than self" do
      expect(array1.zip(array4)).to eq([
                                    ['a', 7],
                                    ['b', 8],
                                    ['c', 9]
                                  ])
    end
    it "adds nil when argument arrays are shorter than self" do
      expect(array1.zip(array5)).to eq([
                                    ['a', 100],
                                    ['b', nil],
                                    ['c', nil]
                                  ])
    end
  end

  describe "#my_flatten" do
    it "returns an already flattened array" do
      expect([1, 2, 3, 4].my_flatten).to eq([1, 2, 3, 4])
    end
    it "flattens nested array" do
      expect([[1, 2, [3]], [[4, 5], 6], 7].my_flatten).to eq([1, 2, 3, 4, 5, 6, 7])
    end
  end

  describe "#bubble_sort!" do
    let(:array) { [1, 2, 3, 4, 5].shuffle }

    it "works with an empty array" do
      expect([].bubble_sort!).to eq([])
    end

    it "works with an array of one item" do
      expect([1].bubble_sort!).to eq([1])
    end

    it "sorts numbers" do
      expect(array.bubble_sort!).to eq(array.sort)
    end

    it "modifies the original array" do
      duped_array = array.dup
      array.bubble_sort!
      expect(duped_array).not_to eq(array)
    end

    it "will use a block if given" do
      sorted = array.bubble_sort! do |num1, num2|
        # order numbers based on descending sort of their squares
        num2**2 <=> num1**2
      end

      expect(sorted).to eq([5, 4, 3, 2, 1])
    end
  end

  describe "#bubble_sort" do
    let(:array) { [1, 2, 3, 4, 5].shuffle }

    it "delegates to #bubble_sort!" do
      expect_any_instance_of(Array).to receive(:bubble_sort!)

      array.bubble_sort
    end

    it "does not modify the original array" do
      duped_array = array.dup
      array.bubble_sort
      expect(duped_array).to eq(array)
    end
  end

  describe "#my_each" do
    it "calls the block passed to it" do
      expect do |block|
        ["test array"].my_each(&block)
      end.to yield_control.once
    end

    it "yields each element to the block" do
      expect do |block|
        ["el1", "el2"].my_each(&block)
      end.to yield_successive_args("el1", "el2")
    end

    it "does NOT call the built-in #each method" do
      original_array = ["original array"]
      expect(original_array).not_to receive(:each)
      original_array.my_each {}
    end

    it "is chainable and returns the original array" do
      original_array = ["original array"]
      expect(original_array.my_each {}).to eq(original_array)
    end
  end

  describe "#my_map" do
    it "calls the block passed to it" do
      expect do |block|
        ["test array"].my_map(&block)
      end.to yield_control.once
    end

    it "yields each element to the block" do
      expect do |block|
        ["el1", "el2"].my_map(&block)
      end.to yield_successive_args("el1", "el2")
    end

    it "runs the block for each element" do
      expect([1, 2, 3].my_map { |el| el * el }).to eq([1, 4, 9])
      expect([-1, 0, 1].my_map { |el| el.odd? }).to eq([true, false, true])
    end

    it "does NOT call the built in built-in #map method" do
      original_array = ["original array"]
      expect(original_array).not_to receive(:map)
      original_array.my_map {}
    end

    it "is chainable and returns a new array" do
      original_array = ["original array"]
      expect(original_array.my_map {}).not_to eq(original_array)
    end
  end

  describe "#my_all?" do
    it "calls the block passed to it" do
      expect do |block|
        ["test element"].my_all?(&block)
      end.to yield_control
    end

    it "returns true and false appropriately" do
      test_array = [1, 2, 3, 4, 5]
      expect(test_array.my_all?(&:odd?)).to be_falsey
      expect(test_array.my_all? { |el| el < 10 }).to be_truthy
    end

    it "does NOT call the built-in #all? method" do
      test_array = ["el1", "el2", "el3"]
      expect(test_array).not_to receive(:all?)
      test_array.my_all? {}
    end
  end

  describe "#my_none?" do
    it "calls the block passed to it" do
      expect do |block|
        ["test element"].my_none?(&block)
      end.to yield_control
    end

    it "returns true and false appropriately" do
      test_array = [1, 2, 3, 4, 5]
      expect(test_array.my_none?(&:odd?)).to be_falsey
      expect(test_array.my_none? { |el| el > 10 }).to be_truthy
    end

    it "does NOT call the built-in #none? method" do
      test_array = ["el1", "el2", "el3"]
      expect(test_array).not_to receive(:none?)
      test_array.my_none? {}
    end
  end

  describe "#my_any?" do
    it "calls the block passed to it" do
      expect do |block|
        ["test element"].my_any?(&block)
      end.to yield_control
    end

    it "returns true and false appropriately" do
      test_array = [1, 2, 3, 4, 5]
      expect(test_array.my_any?(&:odd?)).to be_truthy
      expect(test_array.my_any? { |el| el > 10 }).to be_falsey
    end

    it "does NOT call the built-in #any? method" do
      test_array = ["el1", "el2", "el3"]
      expect(test_array).not_to receive(:any?)
      test_array.my_any? {}
    end
  end

  describe "#my_join" do
    it "returns a joined string" do
      test_array = ['1', '2', '3', '4', '5']
      expect(test_array.my_join(" ")).to eq("1 2 3 4 5")
      expect(test_array.my_join("haha")).to eq("1haha2haha3haha4haha5")
    end

    it "does NOT call the built-in #join method" do
      test_array = ["el1", "el2", "el3"]
      expect(test_array).not_to receive(:join)
      test_array.my_join("this is a really funny separator")
    end
  end

end

describe "#doubler" do
  let(:array) { [1, 2, 3] }

  it "doubles the elements of the array" do
    expect(doubler(array)).to eq([2, 4, 6])
  end

  it "does not modify the original array" do
    duped_array = array.dup

    doubler(array)

    expect(array).to eq(duped_array)
  end
end

describe "#subwords" do
  it "can find a simple word" do
    words = subwords("asdfcatqwer", ["cat", "car"])
    expect(words).to eq(["cat"])
  end

  it "doesn't find spurious words" do
    words = subwords("batcabtarbrat", ["cat", "car"])
    expect(words).to be_empty
  end

  it "can find words within words" do
  #note that the method should NOT return duplicate words
    dictionary = ["bears", "ear", "a", "army"]
    words = subwords("erbearsweatmyajs", dictionary)

    expect(words).to eq(["bears", "ear", "a"])
  end
end

describe "#factors" do
  it "returns factors of 10 in order" do
    expect(factors(10)).to eq([1, 2, 5, 10])
  end

  it "returns just two factors for primes" do
    expect(factors(13)).to eq([1, 13])
  end
end

describe "#merge_sort" do
  # write a new `Array#merge_sort` method; it should not modify the
  # array it is called on, but creates a new sorted array.
  let(:array) { [1, 2, 3, 4, 5].shuffle }

  it "works with an empty array" do
    expect([].merge_sort).to eq([])
  end

  it "works with an array of one item" do
    expect([1].merge_sort).to eq([1])
  end

  it "sorts numbers" do
    expect(array.merge_sort).to eq(array.sort)
  end

  it "will use block if given" do
    reversed = array.merge_sort do |num1, num2|
      # reverse order
      num2 <=> num1
    end
    expect(reversed).to eq([5, 4, 3, 2, 1])
  end

  it "does not modify original" do
    duped_array = array.dup
    duped_array.merge_sort
    expect(duped_array).to eq(array)
  end

  it "calls the merge helper method" do
    expect(Array).to receive(:merge).at_least(:once).and_call_original
    array.merge_sort
  end
end

describe "#quick_sort" do
  let(:array) { [1, 2, 3, 4, 5].shuffle }

  it "works with an empty array" do
    expect([].quick_sort).to eq([])
  end

  it "works with an array of one item" do
    expect([1].quick_sort).to eq([1])
  end

  it "sorts numbers" do
    expect(array.quick_sort).to eq(array.sort)
  end

  it "will use block if given" do
    reversed = array.quick_sort do |num1, num2|
      # reverse order
      num2 <=> num1
    end
    expect(reversed).to eq([5, 4, 3, 2, 1])
  end

  it "does not modify original" do
    duped_array = array.dup
    duped_array.quick_sort
    expect(duped_array).to eq(array)
  end
end

describe "#aliquot_sequence" do
  it "returns the sequence of 0" do
    expect(aliquot_sequence(0)).to eq([0])
  end

  it "returns the aliquot_sequence of a larger number" do
    expect(aliquot_sequence(20)).to eq([20, 22, 14, 10, 8, 7, 1, 0])
  end
end

describe "#sum" do
  it "returns 0 for an empty array" do
    expect(sum([])).to eq(0)
  end

  it "returns the sum of all numbers in array" do
    expect(sum([1, 3, 5, 7, 9, 2, 4, 6, 8])).to eq(45)
  end

  it "does not modify the original array" do
    original = [1, 3, 5, 7, 9, 2, 4, 6, 8]
    sum(original)
    expect(original).to eq([1, 3, 5, 7, 9, 2, 4, 6, 8])
  end

  it "calls itself recursively" do
    expect(self).to receive(:sum).at_least(:twice).and_call_original
    sum([1, 3, 5, 7, 9, 2, 4, 6, 8])
  end
end

describe "Array#binary_search" do
  let (:arr) { [0, 1, 2, 3, 4, 5, 6] }

  it "returns nil if target not found" do
    expect(arr.binary_search(20)).to be_nil
  end

  it "returns the index of the middle element" do
    expect(arr.binary_search(3)).to eq(3)
  end

  it "returns the index of an early element" do
    expect(arr.binary_search(1)).to eq(1)
  end

  it "returns the index of a later element" do
    expect(arr.binary_search(5)).to eq(5)
  end
end

describe "#my_include?" do
  it "returns false if the target isn't found" do
    expect(my_include?([1, 3, 5, 7, 9, 2, 4, 6, 8], 11)).to be(false)
  end

  it "returns true if the target is found" do
    expect(my_include?([1, 3, 5, 7, 9, 2, 4, 6, 8], 9)).to be(true)
  end

  it "does not modify the original array" do
    original = [1, 3, 5, 7, 9, 2, 4, 6, 8]
    my_include?(original, 9)
    expect(original).to eq([1, 3, 5, 7, 9, 2, 4, 6, 8])
  end

  it "calls itself recursively" do
    expect(self).to receive(:my_include?).at_least(:twice).and_call_original
    my_include?([1, 3, 5, 7, 9, 2, 4, 6, 8], 9)
  end
end

describe "#my_uniq?" do
  let(:array) { [1, 2, 3, 4, 5, 5].shuffle }
  let(:big_unique) { (1..1000).to_a.shuffle }
  let(:big_non_unique) { big_unique + [9] }

  it "works with an empty array" do
    expect([].my_uniq?).to be_truthy
  end

  it "returns false for a non-unique array" do
    expect(array.my_uniq?).to be_falsey
  end

  it "returns false for a huge non-unique array" do
    expect(big_non_unique.my_uniq?).to be_falsey
  end

  it "returns true for a huge unique array" do
    expect(big_unique.my_uniq?).to be_truthy
  end
end

describe "#num_occur" do
  it "returns number of times the target occurs in the array" do
    expect(num_occur([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6], 5)).to eq(4)
  end

  it "returns zero if target doesn't occur" do
    expect(num_occur([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6], 13)).to eq(0)
  end

  it "does not modify the original array" do
    original = [1, 3, 5, 7, 9, 2, 4, 6, 8]
    num_occur(original, 9)
    expect(original).to eq([1, 3, 5, 7, 9, 2, 4, 6, 8])
  end

  it "calls itself recursively" do
    expect(self).to receive(:num_occur).at_least(:twice).and_call_original
    num_occur([1, 3, 5, 7, 9, 2, 4, 6, 8], 9)
  end
end

describe "#add_to_twelve?" do
  it "returns true if two adjacent numbers add to twelve" do
    expect(add_to_twelve?([1, 1, 2, 3, 4, 5, 7, 4, 5, 6, 7, 6, 5, 6])).to be(true)
  end

  it "returns false if no adjacent numbers add to twelve" do
    expect(add_to_twelve?([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6])).to be(false)
  end

  it "does not modify the original array" do
    original = [1, 3, 5, 7, 9, 2, 4, 6, 8]
    add_to_twelve?(original)
    expect(original).to eq([1, 3, 5, 7, 9, 2, 4, 6, 8])
  end

  it "calls itself recursively" do
    expect(self).to receive(:add_to_twelve?).at_least(:twice).and_call_original
    add_to_twelve?([1, 3, 5, 7, 9, 2, 4, 6, 8])
  end
end

describe "#sorted?" do
  it "returns true if the array has only one value" do
    expect(sorted?([1])).to be(true)
  end

  it "returns true if the array is empty" do
    expect(sorted?([])).to eq(true)
  end

  it "returns true if the array is sorted" do
    expect(sorted?([1, 2, 3, 4, 4, 5, 6, 7])).to be(true)
  end

  it "returns false if the array is not sorted" do
    expect(sorted?([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6])).to be(false)
  end

  it "does not modify the original array" do
    original = [1, 3, 5, 7, 9, 2, 4, 6, 8]
    sorted?(original)
    expect(original).to eq([1, 3, 5, 7, 9, 2, 4, 6, 8])
  end
end

describe "#reverse" do
  it "reverses strings of length <= 1" do
    expect(reverse("")).to eq("")
    expect(reverse("a")).to eq("a")
  end

  it "reverses longer strings" do
    expect(reverse("laozi")).to eq("izoal")
    expect(reverse("kongfuzi")).to eq("izufgnok")
  end

  it "does not modify the original string" do
    original = "fhqwhgads"
    reverse(original)
    expect(original).to eq("fhqwhgads")
  end

  it "calls itself recursively" do
    expect(self).to receive(:reverse).at_least(:twice).and_call_original
    reverse("fhqwhgads")
  end
end

describe "#subsets" do
  let (:array) { [1, 2, 3] }

  it "works with an empty array" do
    expect(subsets([])).to eq([[]])
  end

  it "works with an array of one item" do
    expect(subsets([1])).to eq([[],[1]])
  end

  it "works with a length-three array" do
    expect(subsets(array)).to eq([[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]])
  end
end
