class ChangeYetAgain < ActiveRecord::Migration
  def change
  	change_table :visitor_surveys do |t|
  		t.integer :Jujubes, :default => 0
  		t.integer :Apples, :default => 0

  		remove_column :visitor_surveys, :JujubesApples
  	end
  end
end
