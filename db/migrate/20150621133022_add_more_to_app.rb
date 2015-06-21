class AddMoreToApp < ActiveRecord::Migration
  def change
  	change_table :visitor_applications do |t|
      t.boolean	:operators_other
    end
  end
end
