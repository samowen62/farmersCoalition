class AddToAccessibilities < ActiveRecord::Migration
  def change
  	change_table :accessibilities do |t|
    	t.string "other_access_features_explain"
    	t.string "SNAP_offer_other"
    	t.string "FMNP_offer_other"
    	t.string "FMNP_senior_offer_other"
    	t.string "CVV_offer_other"
    end
  end
end
