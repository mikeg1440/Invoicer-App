class Account < ApplicationRecord
  belongs_to :user
  belongs_to :client
  has_many :invoices
  has_many :products, through: :invoices
end
