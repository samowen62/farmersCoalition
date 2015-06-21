class AddVisitorApplication < ActiveRecord::Migration
  def change
  	create_table :visitor_applications do |t|
  		t.float :farm_sales
  		t.float :value_sales
  		t.float :ready_sales
  		t.float :other_sales
  		t.string :level_of_sales
  		
  		t.text	:primary_loc
  		t.text	:secondary_loc

  		t.float :acres_owned
  		t.float	:acres_leased
  		t.float :acres_cultivated
  		t.string	:level_of_acres
  		#metric 5 ?
  		t.integer	:workers_seasonal, :default => 0	
  		t.integer 	:workers_yearly, :default => 0
  		t.string	:level_of_worker_anticipation
  		#metric 10 is the same as 4?

  		t.integer	:owner1_years
  		t.integer	:owner2_years

  		t.string	:owned_by_women

  		t.string	:primary_operators
  		#select field^^
  		t.string	:primary_operators_other

  		t.boolean	:certified_organic
  		t.boolean	:certified_natural
  		t.boolean	:certified_biodynamic
  		t.boolean	:certified_food_alliance
  		t.boolean	:certified_other
  		t.string	:certified_other_name
  		t.boolean	:certified_none

  		t.integer	:num_certified

  		#ask about 27 text?

  		t.integer	:under_35

  		t.float		:total_distance
  		t.integer	:num_locations
      #ask about years (current or former?)
      #and about 2 v 10 also since 2 is req'd and they're the same
  	end
  end
end
