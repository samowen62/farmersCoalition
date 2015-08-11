class AddNameToApp < ActiveRecord::Migration
  def change
  	change_table :visitor_applications do |t|
     t.string	:vendor_name
    end
  end
end
