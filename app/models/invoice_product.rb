class InvoiceProduct < ApplicationRecord

  belongs_to :invoice
  belongs_to :product

  validates :product_id, presence: :true
  validates :quantity, presence: :true


end
