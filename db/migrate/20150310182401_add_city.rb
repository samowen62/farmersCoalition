class AddCity < ActiveRecord::Migration
    def change
  	change_table :profiles do |t|
  		t.string :city
  	end
  end
end
