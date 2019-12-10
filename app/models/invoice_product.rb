class InvoiceProduct < ApplicationRecord

  belongs_to :invoice, optional: true
  belongs_to :product

  validates :product_id, presence: :true
  validates :quantity, presence: :true


end
