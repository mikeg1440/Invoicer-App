class Client < ApplicationRecord
  has_many :accounts
  has_many :invoices, through: :accounts

  validates :name, presence: true
  validates :email, presence: true
end
