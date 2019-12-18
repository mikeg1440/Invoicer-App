class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github]

  has_many :accounts
  has_many :invoices, through: :accounts
  has_many :clients, through: :accounts
  has_many :invoice_products, through: :invoices
  # has_many :products, through: :invoices
  has_many :products

  devise :database_authenticatable, :timeoutable

  validates :username, presence: true
  validates :email, presence: true
  # validates :name, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.nickname
      # user.avatar_url = auth.info.image     # we would need to add the avatar_url and urls attributes to user table to save these next 2 lines
      # user.urls = auth.info.urls
    end
  end

end
