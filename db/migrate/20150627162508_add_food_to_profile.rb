class AddFoodToProfile < ActiveRecord::Migration
  def change
  	create_table :food_assistance do |t|
	    t.references :profile, index: true
	    t.date		:transaction_date
	    t.string	:type_of_assistance
	    t.string	:digits_of_snap
	    t.float		:redeemed
	    t.string	:zip_code
	    t.boolean	:first_name
	end
  end
end
