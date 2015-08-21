class AddIncentiveCampaign < ActiveRecord::Migration
  def change
  	change_table :food_assistance do |t|
     t.string	:incentive_campaign
    end
  end
end
