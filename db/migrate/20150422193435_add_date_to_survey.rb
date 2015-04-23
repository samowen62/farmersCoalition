class AddDateToSurvey < ActiveRecord::Migration
  def change
  	change_table :visitor_surveys do |t|
  		t.date	"date"
  	end
  end
end
