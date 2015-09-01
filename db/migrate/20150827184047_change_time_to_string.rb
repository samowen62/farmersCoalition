class ChangeTimeToString < ActiveRecord::Migration
  def change
  	change_column :volunteers, :arrival, :string
  	change_column :volunteers, :departure, :string
  end
end
