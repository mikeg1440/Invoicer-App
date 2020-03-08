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
admin = User.create(username: 'admin', email: 'admin@mail.com', password: 'admin123', admin: true)

# create some products
# admin.products.create(name: 'Debugging', description: 'Identifying and removing errors from computer hardware or software', price: 20)
# admin.products.create(name: 'Incident Response', description: 'Organizing a approach to addressing and managing the aftermath of a security breach or cyberattack.', price: 150)
# admin.products.create(name: 'Code Review', description: 'Systematic examination of computer source code. It is intended to find and fix mistakes overlooked in the initial development phase, improving both the overall quality of software and the developers skills.', price: 35)
# admin.products.create(name: 'Web Accesiblity Management', description: 'Ensuring there are no barriers that prevent interaction with, or access to, websites on the World Wide Web by people with physical disabilities, situational disabilities, and socio-economic restrictions on bandwidth and speed.', price: 80)
# admin.products.create(name: 'Coding', description: 'The process of developing and implementing various sets of instructions to enable a computer to do a certain task.', price: 35)
# admin.products.create(name: 'Cyber Security Assesment', description: 'A risk-based approaches to examine and enhance defense mechanisms against cyber-attacks, helps identify threats that could affect the availability and reliability of a system.', price: 135)
# admin.products.create(name: 'Cyber Security Penetration Test', description: 'An authorized simulated cyberattack on a computer system, performed to evaluate the security of the system to expose vulnerabilities and holes in security.', price: 145)



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
    5.times do
      product = user.products.create(name: Faker::Commerce.product_name, price: Faker::Commerce.price, description: Faker::Lorem.sentence(word_count: 13))
      product.save
    end

end



# add 3 products to each invoice using invoice_products
Invoice.all.each do |invoice|
  3.times do
    invoice_product = invoice.invoice_products.new
    invoice_product.product = Product.all.sample
    invoice_product.quantity = rand(10)
    puts "Product Count: #{Product.all.count}"
    invoice_product.total = invoice_product.quantity * invoice_product.product.price
    invoice.save
  end
end
