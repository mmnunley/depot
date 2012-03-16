class LineItem < ActiveRecord::Base
	#Rows in the line_items table are children of 
	#rows in the carts and products tables.
	#No line item can exist unless the corresponding 
	#cart and product rows exist.
	belongs_to :product
	belongs_to :cart
end
