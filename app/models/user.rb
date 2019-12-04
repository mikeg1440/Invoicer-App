class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :accounts
  has_many :invoices, through: :accounts
  has_many :clients, through: :accounts
  has_many :invoice_products, through: :invoices
  has_many :products, through: :invoice_products

  devise :database_authenticatable, :timeoutable

  validates :username, presence: true
  validates :email, presence: true

end
