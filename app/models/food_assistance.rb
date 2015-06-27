class FoodAssistance < ActiveRecord::Base
	self.table_name = "food_assistance"
	belongs_to :profile
end

