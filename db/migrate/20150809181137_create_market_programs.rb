class CreateMarketPrograms < ActiveRecord::Migration
  def change
    create_table :market_programs do |t|
      t.references :profile, index: true
      t.string	:event_type
      t.date	:event_date
      t.boolean	:youth_specific
      t.integer	:participants
      t.integer :under_18
    end
  end
end
