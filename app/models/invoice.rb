class Invoice < ApplicationRecord
  belongs_to :account
  has_many :invoice_products
  has_many :products, through: :invoice_products

  def sub_total
    # require 'pry'; binding.pry
    self.invoice_products.sum(&:total)
  end

  def grand_total
    # if we add options for tax calculation this is were we would do it, for now its the same as sub total
    self.invoice_products.sum(&:total)
  end
end
