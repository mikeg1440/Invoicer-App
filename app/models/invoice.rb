class Invoice < ApplicationRecord
  belongs_to :account
  has_many :invoice_products
  has_many :products, through: :invoice_products

  accepts_nested_attributes_for :invoice_products

  validates :account_id, presence: :true
  validates :due_time, presence: :true


  def sub_total
    self.invoice_products.each {|product_line| product_line.total = product_line.product.price * product_line.quantity}
  end

  def grand_total
    sub_total
    # if we add options for tax calculation this is were we would do it, for now its the same as sub total
    self.invoice_products.sum(&:total)
  end

  def calculate_product_totals
    binding.pry
    self.invoice_products.each do |line|
      line.total = line.product.price * line.quantity
    end
  end
end
