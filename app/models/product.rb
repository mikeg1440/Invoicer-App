class Product < ApplicationRecord

  has_many :invoice_products

  validates :name, presence: :true, uniqueness: :true
  validates :description, presence: :true
  validates :price, presence: :true

end
