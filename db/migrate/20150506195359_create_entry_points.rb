class CreateEntryPoints < ActiveRecord::Migration
  def change
    create_table :entry_points do |t|
      t.references :visitor_counts, index: true
      t.integer "count"
      t.integer "start_hour"
      t.integer "end_hour"

      t.timestamps
    end
  end
end
