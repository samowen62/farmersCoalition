class AddOther < ActiveRecord::Migration
  def change
  	change_table :accessibilities do |t|
    	t.boolean "other_features"
    	t.string "other_features_explain"
    end
  end
end
