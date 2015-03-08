class User < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.string :email
  		t.string :pass
  	end
  end
end
