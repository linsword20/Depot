require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  def setup
    @cart = Cart.new
    @rails_book = products(:rails_book)
    @ruby_book = products(:ruby_book)
  end
  test "add unique product" do
    @cart.add_product @rails_book
    @cart.add_product @ruby_book
    assert_equal @cart.items[0].quantity + @cart.items[1].quantity, 2
    assert_equal @rails_book.price + @ruby_book.price, @cart.total_price
  end

  test "add duplicate product" do
    @cart.add_product @rails_book
    @cart.add_product @rails_book
    assert_equal @cart.items.size, 1
    assert_equal @rails_book.price*2, @cart.total_price
    assert_equal @cart.items[0].quantity, 2
  end
  
end
