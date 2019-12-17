class InvoiceProduct < ApplicationRecord

  belongs_to :invoice, optional: true
  belongs_to :product

  validates :product_id, presence: :true
  validates :quantity, presence: :true
  validates :quantity, numericality: { greater_than_or_equal_to: 1 }

end
