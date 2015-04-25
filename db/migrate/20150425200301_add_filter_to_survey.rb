class AddFilterToSurvey < ActiveRecord::Migration
  def change
  	change_table :visitor_surveys do |t|
  		t.integer	"yes28"
  		t.integer	"no28"
  		t.integer	"yes13"
  		t.integer	"no13"
  		t.integer	"yes36"
  		t.integer	"no36"
  		t.integer	"yes7"
  		t.integer	"no7"
  	end
  end
end
