class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.string :name
      t.references :users, index: true

      t.timestamps
    end
  end
end
