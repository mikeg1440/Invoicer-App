class Invoice < ApplicationRecord
  belongs_to :account
  has_many :invoice_products, dependent: :destroy # when destroy invoice also destroy all invoice_products attached to invoice
  has_many :products, through: :invoice_products

  accepts_nested_attributes_for :invoice_products, reject_if: :product_id.blank?, allow_destroy: true

  validates :account_id, presence: :true
  validates :due_time, presence: :true


  def sub_total
    self.invoice_products.each {|product_line| product_line.total = product_line.product.price * product_line.quantity unless product_line.product.nil? }
  end

  def grand_total
    sub_total
    total = 0
    # if we add options for tax calculation this is were we would do it, for now its the same as sub total
    self.invoice_products.each {|p| total += p.total unless p.total.nil? }
    self.amount_due = total
    self.save
    total
  end

  def calculate_product_totals
    self.invoice_products.each do |line|
      line.total = line.product.price * line.quantity
    end
    self.save
  end
end
