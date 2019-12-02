class Client < ApplicationRecord
  has_many :accounts
  has_many :invoices, through: :accounts 
end
