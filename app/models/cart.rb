class Cart < ActiveRecord::Base
	#A cart has many items in the cart
	#The existence of line_items is dependent on the existence of the cart.
	has_many :line_items, :dependent => :destroy

	def add_product(product_id)
		#Try and find the line item in the current cart based
		#on the product ID.
		#Active record is smart enough to know "find_by" and
		#ending in the column name of line_items. It searches.
		current_item = line_items.find_by_product_id(product_id)
		#If the product ID is found then add to the quantity
		if current_item
			current_item.quantity += 1
		#if the product ID is not found, then build the product
		else
			#Pass the product that was found into "build"
    		#this causes new line item relationship to be built 
    		#between the @cart object and the product
    		##@line_item = @cart.line_items.build(:product => product)
			current_item = line_items.build(:product_id => product_id)
		end
		#return either the quantity or the new item
		current_item
	end

	def decrease(line_item_id)
    	current_item = line_items.find(line_item_id)
	    if current_item.quantity > 1
	      current_item.quantity -= 1
	    else
	      current_item.destroy
	    end
    current_item
  	end

  	def increase(line_item_id)
	    current_item = line_items.find(line_item_id)
	    current_item.quantity += 1
	    current_item
  	end

	#This grabs all line items and puts them into an array
	#After the array is made it sums the items in the array 
	#up using the total_price method
	def total_price
		line_items.to_a.sum { |item| item.total_price }
	end

	def total_items
		line_items.sum(:quantity)
	end
end
