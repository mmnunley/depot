class ApplicationController < ActionController::Base
  protect_from_forgery


  private 

  def current_cart
  	#This finds the :cart_id from the 
  	#session object and attempts to find 
    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end
  	#the cart corresponding to this ID. 
  	Cart.find(session[:cart_id])
  	#If no such object is found the rescue catches it
  rescue ActiveRecord::RecordNotFound
  	#creates a new cart
  	cart = Cart.create
  	#Store the id of the created cart into the session
  	session[:cart_id] = cart.id
  	#returns the cart
  	cart
  end
end
