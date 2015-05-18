class AddEntryPoints < ActiveRecord::Migration
  def change
  	create_table :entry_points do |t|
      t.references :profile, index: true
      t.date "day"
      t.integer "period" #0 through 7 for 8 periods

      t.string "start"
      t.string "end"

      t.integer "count"

    end
  end
end
