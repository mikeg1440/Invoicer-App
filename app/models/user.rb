class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # need to add has_secure_password i think
  has_many :invoices
  has_many :clients, through: :invoices
  has_many :products, through: :invoices
end
