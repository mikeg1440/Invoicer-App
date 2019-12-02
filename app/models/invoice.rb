class Invoice < ApplicationRecord
  belongs_to :client
  belongs_to :user

  has_many :products 
end
