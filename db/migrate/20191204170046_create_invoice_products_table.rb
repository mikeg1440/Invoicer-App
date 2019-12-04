class CreateInvoiceProductsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :invoice_products do |t|
      t.integer :product_id
      t.integer :invoice_id
      # t.index [:product_id, :invoice_id], unique: true
    end
  end
end
