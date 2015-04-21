class CreateVistorSurveys < ActiveRecord::Migration
  def change
    create_table :vistor_surveys do |t|
      t.references :profile, index: true
      t.boolean "other_activities"
      t.boolean "morning_activities"
      t.float	"money_activities"

      t.float	"money_market"
      t.boolean	"morning_market"

      t.boolean	"first_time"
      t.string	"frequency"

      t.boolean "personal_vehicle"
      t.string	"vehicle"

      t.string 	"home_zip"

      t.boolean	"fruits"
      t.string	"fruit1"
      t.string	"fruit2"
      t.string	"fruit3"

      t.timestamps
    end
  end
end
