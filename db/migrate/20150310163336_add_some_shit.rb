class AddSomeShit < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.string :crap
  	end
  end
end
