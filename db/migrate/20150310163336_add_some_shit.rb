class AddSomeShit < ActiveRecord::Migration
  def change
  	change_table :profiles do |t|
  		t.string :state
  		t.string :address
  		t.string :county
  		t.integer :year
  		#5 days/hrs in a week
  		#6 has many market seasons
  		#market obj(opening d/m/y, closing d/m/y, season, location<primary for this one>)
  		t.boolean :multiple_locs
  		#market objs, for other locs/seasons for locs
  		t.boolean :year_round
  		t.string :host_name
  		t.string :incorporated
  		# (#10 with opts)
  		t.boolean :FMC_member
  		t.string :other_associations
  		t.boolean :mission_statement
  		#where mission statement located
  		t.boolean :ms_website
  		t.boolean :ms_manual
  		t.boolean :ms_market_promos
  		t.boolean :ms_none
  		t.boolean :ms_other
  		t.string :ms_other_text
  		t.date :when_ms
  		t.string :person_decisions
  		t.text :list_of_persons
  		t.string :logo_path
  	end
  end
end
