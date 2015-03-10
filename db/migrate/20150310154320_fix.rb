class Fix < ActiveRecord::Migration
  def change
    rename_column :profiles, :users_id, :user_id

    drop_table :infos
  end
end
