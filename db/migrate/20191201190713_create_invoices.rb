class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.integer :amount_due #, t.decimal :amount_due, precision: 2 
      t.datetime :due_time
      t.string :status
      t.integer :account_id


      t.timestamps
    end
  end
end
