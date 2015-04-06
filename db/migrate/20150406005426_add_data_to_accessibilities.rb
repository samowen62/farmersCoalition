class AddDataToAccessibilities < ActiveRecord::Migration
  def change
  	change_table :accessibilities do |t|
    	t.boolean "bus_sub"
    	t.boolean "bike_racks"
    	t.boolean "sidewalks"
    	t.boolean "free_parking"
    	t.boolean "roof"
    	t.boolean "other_access"
    	t.string "other_access_explain"
    	t.string "selling_space"
    	t.boolean "children_activities"
    	t.boolean "live_music"
    	t.boolean "food_demonstrations"
    	t.boolean "restrooms"
    	t.integer "restroom_count"
    	t.boolean "accept_SNAP"
    	t.string "SNAP_offer"
    	t.boolean "FMNP_available"
    	t.boolean "accept_FMNP"
    	t.string "FMNP_offer"
    	t.boolean "FMNP_senior_available"
    	t.boolean "accept_FMNP_senior"
    	t.string "FMNP_senior_offer"
    	t.boolean "CVV_available"
    	t.boolean "accept_CVV"
    	t.string "CVV_offer"
    	t.boolean "other_vouchers"
    	t.text "other_vouchers_explain"
    end
  end
end
