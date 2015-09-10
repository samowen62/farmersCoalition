class AddTotalGross < ActiveRecord::Migration
  def change
  	change_table :visitor_applications do |t|
  		t.float 	:total_gross
  	end
  end
end
