class Product < ActiveRecord::Base
	#Sorts all the products in alphabetical order based on title
	default_scope :order => 'title'

	has_many :line_items
	#This says that there is a relationship between products
	#and orders through the line_items relationship
	has_many :orders, :through => :line_items
	#This is a hook that ensures that there are no references 
	#to a line_item before it is destroyed.
	before_destroy :ensure_not_referenced_by_any_line_item
	validates :title, :description, :image_url, :presence => true
	validates :price, :numericality => {:greater_than_or_equal_to => 0.01, :less_than_or_equal_to =>  1000 }
	validates :title, :uniqueness => true
	validates :title, :length => {:minimum => 8,
		:too_short => "%{count} characters is least amount allowed" }
	validates :image_url, :format => {
		:with => %r{\.(gif|jpg|png)$}i,
		:message => 'must be a URL for GIF, JPG or PNG image.'}
	validates :image_url, :uniqueness => true
	private

	#ensure that there are no line_items referencing this product.
	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			#This adds to the :base errors on this page that 
			#are associated with validation
			errors.add(:base, 'Line Items present')
			return false
		end
	end
end
