class AddOtherCol < ActiveRecord::Migration
  def change
  	change_table :profiles do |t|
  		t.string "incorporated_other"
  	end
  end
end
