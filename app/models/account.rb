class Account < ApplicationRecord
  belongs_to :user
  belongs_to :client
  has_many :invoices
  has_many :invoice_products, through: :invoices
  has_many :products, through: :invoice_products

  accepts_nested_attributes_for :client

  validates :name, presence: true, uniqueness: true

  validates :user, presence: true

end
