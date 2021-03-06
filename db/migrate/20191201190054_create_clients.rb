class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :name,                null: false, default: ""
      t.string :email,               null: false, default: ""
      t.string :business_name
      t.string :phone_number
      t.string :address

      t.timestamps
    end
  end
end
