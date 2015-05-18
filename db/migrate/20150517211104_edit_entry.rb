class EditEntry < ActiveRecord::Migration
  def change
  	change_table :entry_points do |t|
  		t.integer    "int_day"
  		t.date		"date"
  	end
  end
end
