class AddMetricToProfile < ActiveRecord::Migration
  def change
  	change_table :profiles do |t|
  		t.integer "metrics_1" #ints are max 2^31
  		t.integer "metrics_2"
  	end
  end
end
