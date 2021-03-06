class Account < ApplicationRecord
  belongs_to :user
  belongs_to :client
  has_many :invoices, dependent: :destroy
  has_many :invoice_products, through: :invoices
  has_many :products, through: :invoice_products

  accepts_nested_attributes_for :client, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true


  def self.find_or_build_by(params, user)

    account = self.find_by(user_id: user.id, client_id: params[:client_id])
    if account
      account
    else
      user.accounts.build(params)
    end
  end


end
