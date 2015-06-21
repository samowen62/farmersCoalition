class AddToApp < ActiveRecord::Migration
  def change
    change_table :visitor_applications do |t|
      t.boolean	:operators_white
      t.boolean	:operators_mexican
      t.boolean	:operators_black
      t.boolean	:operators_indian
      t.boolean	:operators_asian


      t.text	:unique_crops
    end
  end
end
