class DeleteTables < ActiveRecord::Migration
  def change
  	drop_table :entry_points
  	drop_table :vc_entries
  	drop_table :visitor_counts
  	drop_table :vistor_surveys
  end
end
