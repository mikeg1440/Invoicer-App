class CreateInvoiceProductsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :invoice_products do |t|
      t.integer :product_id
      t.integer :invoice_id
      t.integer :total
      t.integer :quantity
    end
  end
end
