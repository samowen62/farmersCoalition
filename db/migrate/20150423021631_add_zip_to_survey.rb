class AddZipToSurvey < ActiveRecord::Migration
  def change
  	change_table :visitor_surveys do |t|
  		t.text	"home_zip"
  	end
  end
end

