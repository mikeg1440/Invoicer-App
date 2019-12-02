class Client < ApplicationRecord
  has_many :invoices
  belongs_to :user, through: :invoices  

end
