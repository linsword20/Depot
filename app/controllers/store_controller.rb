class StoreController < ApplicationController
 ###解决代码冗余
  before_filter :find_cart, :except => :empty_cart
  def index
	@products = Product.find_products_for_sale
	#@cart = find_cart
	#访问index计数器
	if session[:counter].nil? 
	    session[:counter] = 1
	else 
 	    session[:counter] += 1
	end
  end
#######add to cart  
  def add_to_cart
	product = Product.find(params[:id])
	#@cart = find_cart
	@current_item = @cart.add_product(product)##调用cart模型方法

	respond_to do |format|
	  format.js if request.xhr?
	  format.html{redirect_to_index}
	end

	session[:counter] = 0
  rescue ActiveRecord::RecordNotFound
	logger.error("Attempt to access invalid product #{params[:id]}")
	redirect_to_index("Invalid product")
  end
 
=begin 
  def decrease_cart_item
    product = Product.find(params[:id])
    @cart = session[:cart]
    @current_item = @cart.decrease_quantity(product)
    redirect_to_index unless request.xhr?
  end
=end
######empty cart
  def empty_cart
	session[:cart] = nil
	
	  respond_to do |format|
	  format.js if request.xhr?
	  format.html{redirect_to_index}
	end
  end
  def checkout
	#@cart = find_cart
	if @cart.items.empty?
	  redirect_to_index("Your cart is empty")
	else
	  @order = Order.new
	end
  end

  def save_order
	#@cart = find_cart
	@order = Order.new(params[:order])
	@order.add_line_items_from_cart(@cart)
	if @order.save
	  session[:cart] = nil
	  redirect_to_index(I18n.t('flash.thanks' ))
	else
	  render :action => 'checkout'
	end
  end

protected

  def authorize
  end


private  
  
  def find_cart
	unless session[:cart]
	  session[:cart] = Cart.new
	end
	@cart = session[:cart]
  end


  def redirect_to_index(msg = nil)
	flash[:notice] = msg if msg
	redirect_to :action => 'index'
  end


end
