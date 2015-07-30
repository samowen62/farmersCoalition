class LinkProfile < ActiveRecord::Migration
  def change
  	change_table :misc_researches do |t|
     t.references :profile, index: true
    end
  end
end
