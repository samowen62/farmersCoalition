class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
    	#will have to reference instruments in the future
      t.string		"name"
      t.text 		"description"

      t.string		"text1"
      t.string 		"text2"
      t.string		"text3"
      t.string		"text4"

      t.string		"date1"
      t.string 		"date2"
      t.string		"date3"
      t.string		"date4"

      #SEPARATE ITEMS IN LISTS OF OPTIONS WITH <|> WHICH IS COMPUTED
      #FROM THE DATA SUBMITTED ON THE CLIENT END TO SEPARATE THE ITEMS
      t.string		"check1"
      t.string		"check2"
      t.string		"check3"
      t.string		"check4"
      t.text 		"check1Opts"
      t.text 		"check2Opts"
      t.text 		"check3Opts"
      t.text 		"check4Opts"

      t.string		"radio1"
      t.string		"radio2"
      t.string		"radio3"
      t.string		"radio4"
      t.text 		"radio1Opts"
      t.text 		"radio2Opts"
      t.text 		"radio3Opts"
      t.text 		"radio4Opts"

      t.string		"select1"
      t.string		"select2"
      t.string		"select3"
      t.string		"select4"
      t.text 		"select1Opts"
      t.text 		"select2Opts"
      t.text 		"select3Opts"
      t.text 		"select4Opts"

      t.timestamps
    end
  end
end
