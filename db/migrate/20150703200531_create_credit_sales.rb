class CreateCreditSales < ActiveRecord::Migration
  def change
    create_table :credit_sales do |t|
      t.references :profile, index: true
      t.date	:transaction_sales
      t.float	:credit_sales
      t.float	:debit_sales
    end
  end
end
