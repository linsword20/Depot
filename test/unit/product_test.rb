require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "invalid with empty attribures" do
    product = Product.new
    assert !product.valid?
    assert product.errors.invalid?(:title) 
    assert product.errors.invalid?(:description)
    assert product.errors.invalid?(:price)
    assert product.errors.invalid?(:image_url)
  end
  test "positive price" do
    product = Product.new(:title => "book",
                          :description => "yyy",
                          :image_url => "zzz.jpg" )
    product.price = -1
    assert !product.valid?
    assert_equal "should be at least 0.01" , product.errors.on(:price)

    product.price = 0
    assert !product.valid?
    assert_equal "should be at least 0.01" , product.errors.on(:price)

    product.price = 1
    assert product.valid?
  end

  test "image_url" do
    ok = %w{ fred.gif fred.jpg fred.png fred.JPG fred.Jpg }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |name|
	product = Product.new(:title => "bk",
                              :description => "yyy",
                              :image_url => name,
                              :price => 1 )
	assert product.valid?, product.errors.full_messages
     end
     bad.each do |name|
	product = Product.new(:title => "bk",
                              :description => "yyy",
                              :image_url => name,
                              :price => 1 )
	assert !product.valid?, "saving #{name}"
     end
  end

  test "unique title" do
    product = Product.new(:title => "Programing Ruby",
                          :description => "yyy",
                          :price => 1,
                          :image_url => "ruby.jpg" )
    assert !product.save
    #assert_equal "has already been taken", product.errors.on(:title)
    assert_equal I18n.t('activerecord.errors.messages.taken'), product.errors.on(:title)
  end  
end
