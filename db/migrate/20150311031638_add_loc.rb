class AddLoc < ActiveRecord::Migration
  def change
  	change_table :markets do |t|
  		t.integer :market_num
  	end
  end
end
