class AddDistsToApp < ActiveRecord::Migration
  def change
  	change_table :visitor_applications do |t|
      t.float	:miles_prim
      t.float	:miles_second
      t.string	:source_prim
      t.string	:dest_prim
      t.string	:source_second
      t.string	:dest_second
    end
  end
end
