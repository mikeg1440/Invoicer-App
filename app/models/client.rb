class Client < ApplicationRecord
  has_many :accounts
  has_many :invoices, through: :accounts

  validates :name, presence: true
  validates :email, presence: true


  def self.find_or_build_by(params, user)

    require 'pry-moves';binding.pry
    client = self.find_by(email: params[:email])
    if client
      client
    else
      user.clients.build(params)
    end
  end

  def client_info
    "#{self.name} - #{self.business_name}"
  end

end
