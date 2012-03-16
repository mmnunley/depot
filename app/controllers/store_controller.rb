class StoreController < ApplicationController
  def index
  	@products = Product.all
  	@page_title = 'Bookshelf for Kings'
  	@carts = Cart.all
	@counter = session[:counter]
  end

end
