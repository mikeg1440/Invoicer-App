class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # need to add has_secure_password i think
  has_many :accounts
  has_many :invoices, through: :accounts
  has_many :clients, through: :accounts
  has_many :products, through: :invoices 
end
