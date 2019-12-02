class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.string :phone_numer
      t.string :address
      t.integer :invoice_id

      t.timestamps
    end
  end
end
