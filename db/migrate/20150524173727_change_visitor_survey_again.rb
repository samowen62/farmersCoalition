class ChangeVisitorSurveyAgain < ActiveRecord::Migration
  def change	  
  	change_table :visitor_surveys do |t|
  		t.integer :Fava_beans, :default => 0
  	end
  end
end
