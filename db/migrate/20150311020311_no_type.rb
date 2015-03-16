class NoType < ActiveRecord::Migration
  def change
  	change_table :markets do |t|
  		rename_column :markets, :type, :market_type
  	end
  end
end
