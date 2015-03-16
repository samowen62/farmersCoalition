class CreateMarkets < ActiveRecord::Migration
  def change
    create_table :markets do |t|
      t.date :start
      t.date :end
      t.text :type
      t.references :profile, index: true

      t.timestamps null: false
    end
  end
end
