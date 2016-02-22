class AddInfoPrefs < ActiveRecord::Migration
  def change
  	create_table :report_prefs do |t|
      t.integer 	:metrics, array:true, default: []
      t.references 	:profile, index: true
    end
  end
end
