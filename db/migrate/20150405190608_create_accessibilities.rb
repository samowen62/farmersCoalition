class CreateAccessibilities < ActiveRecord::Migration
  def change
    create_table :accessibilities do |t|
      t.references :profile, index: true

      t.timestamps
    end
  end
end
