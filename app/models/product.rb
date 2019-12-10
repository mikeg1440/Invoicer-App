class Product < ApplicationRecord

  has_many :invoice_products
  belongs_to :user

  validates :name, presence: :true, uniqueness: :true
  validates :description, presence: :true
  validates :price, presence: :true

end
