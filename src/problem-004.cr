# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.

# Find the largest palindrome made from the product of two 3-digit numbers.

struct Int
  def palindrome?
    self.to_s == self.to_s.reverse
  end
end

# result = 0
# (100..999).each do |i|
#   (i..999).each do |j|
#     if i*j > result && (i*j).palindrome?
#       result = i*j
#     end
#   end
# end

# nums = Iterator.new do |y|
#   (100..999).each do |i|
#     (i..999).each do |j|
#       y << i * j
#     end
#   end
# end

# nums.select(&.palindrome?).max


# puts (100..999).to_a.product((100..999).to_a).map {|(a, b)| a*b}.select(&.palindrome?).max
# puts result

# class Products
#   include Iterator(Int32)

#   def initialize(fiber)
#     @work = fiber
#     # @i = 100
#     # @j = 100
#   end

#   def next
#     return @work.resume
#     # output = @i*@j
#     # if @j == 1000
#     #   if @i == 999
#     #     return Iterator::Stop::INSTANCE
#     #   else
#     #     @i += 1
#     #     @j = @i
#     #     output = @i*@j
#     #   end
#     # else
#     #   @j += 1
#     # end
#     # return output
#   end
# end

# puts Products.new.select(&.palindrome?).max
# products = Fiber.new do
#   (100..999).each do |i|
#     (i..999).each do |j|
#       Fiber.yield i * j
#     end
#   end
#   Fiber.yield Iterator::Stop::INSTANCE
# end

# products.select(&.palindrome?).max

chan = Channel(Int32 | Iterator::Stop).new
spawn do
  (100..999).each do |i|
    (i..999).each do |j|
      chan.send i * j
    end
  end
  chan.send Iterator::Stop::INSTANCE
end

class Products
  include Iterator(Int32)
  def initialize(chan : Channel(Int32 | Iterator::Stop))
    @chan = chan
  end

  def next
    @chan.receive
  end
end

products = Products.new(chan)
puts products.select(&.palindrome?).max
