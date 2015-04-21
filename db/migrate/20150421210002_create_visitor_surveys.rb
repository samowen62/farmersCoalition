class CreateVisitorSurveys < ActiveRecord::Migration
  def change
    create_table :visitor_surveys do |t|
    	t.references :profile, index: true
    	t.integer	"bikes"
    	t.integer	"walking"
    	t.integer	"bus"
    	t.integer	"taxi"
    	t.integer	"other_method"

    	t.integer	"every_week"
    	t.integer	"every_other_week"
    	t.integer	"every_month"
    	t.integer	"less_than_month"

    	t.float 	"spent_morning"
    	t.float		"spent_afternoon"
    	t.float		"downtown_spent_morning"
    	t.float		"downtown_spent_afternoon"

    	t.integer	"lettuces"
    	t.integer	"roots"
    	t.integer	"tomatoes"
    	t.integer	"corn"
    	t.integer	"melons"
    	t.integer	"berries"

    	t.timestamps
    end
  end
end
