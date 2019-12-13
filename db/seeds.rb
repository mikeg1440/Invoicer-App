# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Config our locale for Faker gem
Faker::Config.locale = 'en-US'

# create default admin user
User.create(username: 'admin', email: 'admin@mail.com', password: 'admin123', admin: true)

# create 5 random users with default password 'password'
5.times do
  name = Faker::Name.first_name
  User.create(username: name, email: "#{name}@mail.com",password: 'password')
end

# create client and accounts for each user
User.all.each do |user|
  # generate a fake company name
  client_name = Faker::Name.name
  business_name = Faker::Company.name
  # generate a fake due time (random time between today and 14 days in the future)
  due_time = Faker::Time.between(from: DateTime.now, to: DateTime.now + 14)

  # create our new client
  client = Client.create(name: client_name, business_name: business_name,email: "#{client_name.gsub(" ","")}@mail.com", phone_number: Faker::PhoneNumber.cell_phone, address: Faker::Address.full_address)

  # create account and invoice for account
  account = Account.create(name: "Account for #{client_name}", user: user, client: client)
  account.invoices.build(due_time: due_time, status: 'draft')
  account.save

  # create 3 products
    3.times do
      product = Product.create(name: Faker::Commerce.product_name, price: Faker::Commerce.price, description: Faker::Lorem.sentence(word_count: 13))
      product.user = user
      product.save
    end

end



# add 3 products to each invoice using invoice_products
Invoice.all.each do |invoice|
  3.times do
    invoice_product = invoice.invoice_products.new
    invoice_product.product = Product.all.sample
    invoice_product.quantity = rand(10)
    invoice_product.total = invoice_product.quantity * invoice_product.product.price
    invoice.save
  end
end
