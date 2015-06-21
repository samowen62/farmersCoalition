class AddProfileIndexToApps < ActiveRecord::Migration
  def change
    change_table :visitor_applications do |t|
      t.references :profile, index: true
    end
  end
end
