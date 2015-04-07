class EditCommunity < ActiveRecord::Migration
  def change
  	change_table :communities do |t|
  		t.boolean :customers
  		t.boolean :municipal
  		t.boolean :producers
  		t.boolean :extension
  		t.boolean :community_groups
  		t.boolean :advisors_other
  		t.text :sponsors
  		t.boolean :newsletter
  		t.boolean :facebook
  		t.boolean :twitter
  		t.boolean :google
  		t.boolean :pinterest
  		t.boolean :online_other
  		t.string :online_other_explain
  		t.boolean :annual_report
  		t.string :report_link
  		t.boolean :experience_collecting
  		t.text :resources_available
  	end
  end
end
