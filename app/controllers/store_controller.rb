class StoreController < ApplicationController
  def index
  	@products = Product.all
  	@page_title = 'Bookshelf for Kings'
  	@cart = current_cart
	# @counter = session[:counter]
  end

end
