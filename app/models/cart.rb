class Cart < ActiveRecord::Base
	#A cart has many items in the cart
	#The existence of line_items is dependent on the existence of the cart.
	has_many :line_items, :dependent => :destroy
end
