class EditApplication < ActiveRecord::Migration
  def change
  	change_table :visitor_applications do |t|
      t.string	:acres_anticipation
      t.string	:certified_organic_number
      t.string	:certified_naturaly_number
      t.string	:certified_biodynamic_number
      t.string	:food_alliance_number
      t.string	:other_certification_number

      t.float	:hours_brassica
      t.float	:hours_sprouts
      t.float	:hours_lettuce
      t.float	:hours_beans
      t.float	:hours_carrots
      t.float	:hours_tomatoes
      t.float	:hours_corn
      t.float	:hours_melons
      t.float	:hours_berries

    end
  end
end
