class AddNumToEntryPt < ActiveRecord::Migration
  def change
  	change_table :entry_points do |t|
      t.integer "num"

    end
  end
end
