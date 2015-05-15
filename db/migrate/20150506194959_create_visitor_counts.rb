class CreateVisitorCounts < ActiveRecord::Migration
  def change
    create_table :visitor_counts do |t|
      t.references :profile, index: true
      t.date "day"
      t.integer "period" #0 through 7 for 8 periods


      t.timestamps
    end
  end
end
