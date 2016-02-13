class AddInfoGraphicPrefs < ActiveRecord::Migration
  def change
  	create_table :info_graphic_prefs do |t|
      t.boolean 	:metrics, array:true, default: []
      t.references 	:users, index: true
    end
  end
end
