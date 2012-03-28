class Order < ActiveRecord::Base
	#All line items associated with an order are destroyed when
	#an order is destroyed
	has_many :line_items, :dependent => :destroy

	PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order"]
	validates :name, :address, :email, :pay_type, :presence => true
	#This confirms that only the payment types listed above are in
	#the final order and not false payment types are sent through
	validates :pay_type, :inclusion => PAYMENT_TYPES	

#For each item that leaves the cart we need to do 2 things.
#1) We need to set the cart_id to nil in order to prevent
#the item from going poof when we destroy the cart
#2) Add the item itself to the line_items collection for the order.
#Rails handles all the matching ids
	def add_line_items_from_cart(cart)
		cart.line_items.each do |item|
			item.cart_id = nil
			line_items << item
		end
	end
end
