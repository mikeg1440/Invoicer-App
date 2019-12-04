class Invoice < ApplicationRecord
  belongs_to :account
  has_many :invoice_products
  has_many :products, through: :invoice_products
end
