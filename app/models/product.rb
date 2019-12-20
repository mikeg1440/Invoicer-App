class Product < ApplicationRecord

  has_many :invoice_products
  belongs_to :user

  validates :name, presence: :true, uniqueness: :true
  validates :description, presence: :true
  validates :price, presence: :true


  def self.top_five
    products = {}
    self.all.map do |product|
      products[product] = InvoiceProduct.where(product_id: product.id).count
    end
    products.sort_by {|product, value| value}.last(5).reverse
  end

end
