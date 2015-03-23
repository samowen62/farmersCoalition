class CreateManagement < ActiveRecord::Migration
  def change
    create_table :managements do |t|
    	t.integer "num_staff"
    	t.integer "positions"
    	t.string "other"
    	t.integer "ave_unpaid_market"
    	t.integer "ave_unpaid_non_market"
    	t.integer "ave_paid_market"
    	t.integer "ave_paid_non_market"
    	t.float "annual_budget_for_staff"
    	t.float "annual_operating_budget"
    	t.string "bookKeeper"
    	t.boolean "other_rules"
    	t.string "other_rules_path"

    	#vendors
    	t.float "annual_application_fee"
    	t.float "annual_membership_fee"
    	t.float "percentage_sales"
    	t.float "no_charge"
    	t.float "other_charge"
    	t.string "other_charge_explained"
    	t.integer "ave_num_vendors"
    end
  end
end
