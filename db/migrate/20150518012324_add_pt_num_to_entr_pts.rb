class AddPtNumToEntrPts < ActiveRecord::Migration
  def change
  	change_table :entry_points do |t|
  		t.integer    "ptNum"
  	end
  end
end
