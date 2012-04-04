class Cart
	attr_reader :items
	
	def initialize
		@items = []
	end
	### 添加商品到购物车
	def add_product(product)
		current_item = @items.find{|item| item.product == product }
		if current_item
		  current_item.increment_quantity
		else
		  current_item = CartItem.new(product)
		  @items << current_item
		end
		current_item
	end


	def total_price
		@items.sum {|item| item.price }
	end
	

	def total_items
		@items.sum { |item| item.quantity }
	end

	
=begin
	def decrease_quantity(product) 
    		current_item = @items.find {|item| item.product == product} 
    		if current_item.quantity>1
      			current_item.decrease_quantity 
    		else
      			@items.delete(current_item) #从数组中删除这个对象
      		current_item = nil #因为该对象已经从数组中删除了，后面程序要进行判断是否存在，所以要把它的值赋值为nil 
                end
	

    		current_item
	end
=end
end
