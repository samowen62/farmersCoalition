class CreateSalesSlips < ActiveRecord::Migration
  def change
    create_table :sales_slips do |t|
      t.references :profile, index: true
      t.float	"total_sales"
      t.float	"farm_sales"
      t.float	"value_sales"
      t.float	"ready_sales"

      t.float	"WIC_FMNP_sales"
      t.float	"WIC_sales"
      t.float	"Senior_FMNP_sales"
      t.float	"Debt_sales"
      t.float	"SNAP_sales"
      t.float	"SNAP_transactions"

      t.float	"pounds_donated"
      t.float	"values_donated"

      t.string	"veg1"
      t.string	"veg2"
      t.string	"veg3"

      t.date	"date"

      t.timestamps
    end
  end
end
