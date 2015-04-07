class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.references :profile, index: true

      t.timestamps
    end
  end
end
