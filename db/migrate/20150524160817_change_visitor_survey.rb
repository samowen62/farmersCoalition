class ChangeVisitorSurvey < ActiveRecord::Migration
  def change  	  
  	change_table :visitor_surveys do |t|
  		t.integer :Watermelons, :default => 0
		t.integer :Wineberries, :default => 0
		t.integer :PawPaws, :default => 0
		t.integer :Peaches, :default => 0
		t.integer :Pears, :default => 0
		t.integer :Plums, :default => 0
		t.integer :Quince, :default => 0
		t.integer :Raspberries, :default => 0
		t.integer :Strawberries, :default => 0
		t.integer :Tangerines, :default => 0
		t.integer :Tayberries, :default => 0
		t.integer :Kumquats,  :default => 0
		t.integer :Lemons,  :default => 0
		t.integer :Limes,  :default => 0
		t.integer :Mulberries, :default => 0
		t.integer :Oranges, :default => 0
		t.integer :Fejioas, :default => 0
		t.integer :Figs, :default => 0
		t.integer :Gooseberries, :default => 0
		t.integer :Grapefruit, :default => 0
		t.integer :Grapes, :default => 0
		t.integer :Honeydew_melons, :default => 0  #
		t.integer :JujubesApples, :default => 0
		t.integer :Apricots, :default => 0
		t.integer :Apriums, :default => 0
		t.integer :Asian_pears, :default => 0   #
		t.integer :Avocados, :default => 0
		t.integer :Blackberries, :default => 0
		t.integer :Blueberries, :default => 0
		t.integer :Boysenberries,  :default => 0
		t.integer :Canary_melons, :default => 0   #
		t.integer :Cantaloupes, :default => 0
		t.integer :Cherimoyas, :default => 0
		t.integer :Cherries, :default => 0
		t.integer :Chestnuts, :default => 0
		t.integer :Currants, :default => 0
		t.integer :Dates, :default => 0
  	end
  end
end
