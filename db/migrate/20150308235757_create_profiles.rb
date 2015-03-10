class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.references :users, index: true

      t.timestamps
    end
  end
end
