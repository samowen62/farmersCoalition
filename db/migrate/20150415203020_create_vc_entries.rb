class CreateVcEntries < ActiveRecord::Migration
  def change
    create_table :vc_entries do |t|
      t.references :profile, index: true

      t.timestamps
    end
  end
end
