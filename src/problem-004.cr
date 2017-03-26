# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.

# Find the largest palindrome made from the product of two 3-digit numbers.

struct Int
  def palindrome?
    self.to_s == self.to_s.reverse
  end
end

class Products
  include Iterator(Int32)

  def initialize
    @i = 100
    @j = 100
  end

  def next
    output = @i*@j
    if @j == 1000
      if @i == 999
        return Iterator::Stop::INSTANCE
      else
        @i += 1
        @j = @i
        output = @i*@j
      end
    else
      @j += 1
    end
    return output
  end
end

puts Products.new.select(&.palindrome?).max
