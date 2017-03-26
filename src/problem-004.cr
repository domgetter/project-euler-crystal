# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.

# Find the largest palindrome made from the product of two 3-digit numbers.

struct Int
  def palindrome?
    self.to_s == self.to_s.reverse
  end
end

result = 0
(100..999).each do |i|
  (i..999).each do |j|
    if i*j > result && (i*j).palindrome?
      result = i*j
    end
  end
end

puts result
