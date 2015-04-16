class AddZip < ActiveRecord::Migration
  def change
  	change_table :profiles do |t|
    	t.string "zip"
    end
  end
end
