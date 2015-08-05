class AddHashToUsers < ActiveRecord::Migration
  def change
  	change_table :users do |t|
     t.string	:reset_hash
    end
  end
end
