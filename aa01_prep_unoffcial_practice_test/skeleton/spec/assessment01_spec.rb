require 'rspec'
require 'spec_helper'
require 'assessment01'

describe "#exponentiate" do
  it "raises a number to a power" do
    expect(exponentiate(2, 5)).to eq(32)
  end

  it "raises a number to the power of zero" do
    expect(exponentiate(243, 0)).to eq(1)
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

  describe "#my_flatten" do
    it "returns an already flattened array" do
      expect([1, 2, 3, 4].my_flatten).to eq([1, 2, 3, 4])
    end
    it "flattens nested array" do
      expect([[1, 2, [3]], [[4, 5], 6], 7].my_flatten).to eq([1, 2, 3, 4, 5, 6, 7])
    end
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
