class Client < ApplicationRecord
  has_many :accounts
  has_many :invoices, through: :accounts

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :business_name, uniqueness: true


  def self.find_or_build_by(params, user)
    client = self.find_by(email: params[:email])
    !!client ? client : user.clients.build(params)
  end

  def client_info
    "#{self.name} - #{self.business_name}"
  end

end
