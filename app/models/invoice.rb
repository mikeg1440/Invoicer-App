class Invoice < ApplicationRecord
  belongs_to :account
  has_many :invoice_products, dependent: :destroy # when destroy invoice also destroy all invoice_products attached to invoice
  has_many :products, through: :invoice_products

  accepts_nested_attributes_for :invoice_products, reject_if: :product_id.blank?, allow_destroy: true

  validates :account_id, presence: :true
  validates :due_time, presence: :true


  def invoice_products_attributes=(hash)
    if !!self.id
      self.invoice_products.clear
      hash.values.each do |attributes|
        attrs = attributes.merge({invoice_id: self.id})
        self.invoice_products << InvoiceProduct.find_or_create_by(attrs)
      end
    end
  end


  def grand_total
    sub_total
    self.amount_due = self.invoice_products.map {|p| p.total unless p.total == nil}.reduce(0, :+)
    self.amount_due
  end

  def calculate_product_totals
    self.invoice_products.each do |line|
      line.total = line.product.price * line.quantity
    end
    self.save
  end

  private

  def sub_total
    self.invoice_products.each {|product_line| product_line.total = product_line.product.price * product_line.quantity unless product_line.product.nil? }
  end

end
