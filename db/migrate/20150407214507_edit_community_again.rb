class EditCommunityAgain < ActiveRecord::Migration
  def change
  	change_table :communities do |t|
  		t.boolean :advisors_other_explain
  	end
  end
end
