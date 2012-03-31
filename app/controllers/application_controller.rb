class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize

  private 

  def current_cart
    #Adds a counter to the session for display of items in the cart
    # if session[:counter].nil?
    #   session[:counter] = 1
    # else
    #   session[:counter] += 1
    # end
  	#This finds the :cart_id from the 
  	#session object and attempts to find 
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

protected

#authorizes all pages within the application to ensure the 
#user exists in the database. There is a whitelist filter
#called skip_before_filter :authorize for skipping actions
#related to this authorization. 
  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, :notice => "Please log in"
    end
  end

end
