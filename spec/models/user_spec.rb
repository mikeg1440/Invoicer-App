require "rails_helper"

RSpec.describe User, type: :model do

  let(:user){
    User.create(
      username: 'rich',
      email: 'rich@mail.com',
      password: 'password'
    )
  }
  let(:admin){
    User.create(
      username: 'admin',
      email: 'admin@mail.com',
      password: 'admin123',
      admin: true
    )
  }
  let(:client_1){
    Client.create(
      name: 'Steve Jobs',
      business_name: 'Apple Inc',
      email: 'apple@mail.com',
      phone_number: '(570) 122-7910',
      address: '6801 Northlake Mall Dr, Charlotte, NC 28216'
    )
  }
  let(:client_2){
    Client.create(
      name: 'Sundar Pichai',
      business_name: 'Google LLC',
      email: 'sundarp@gmail.com',
      phone_number: '646-257-4500',
      address: '1600 Amphitheatre Parkway Mountain View, California 94043'
    )
  }
  let(:invoice_1){
    Invoice.create(
      account: account_1,
      status: 'draft',
      due_time: (DateTime.now + 7)
    )
  }
  let(:invoice_2){
    Invoice.create(
      account: account_2,
      status: 'draft',
      due_time: (DateTime.now + 7)
    )
  }


  it 'is valid with a username, email and password' do
    expect(user).to be_valid
  end

  it 'is not valid without a username' do
    new_user = User.create(email: 'email@mail.com', password: 'password')
    expect(new_user.errors.full_messages).to eq(["Username can't be blank"])
  end

  it 'is not valid without a email' do
    new_user = User.create(username: 'Pablo Escobar', password: 'password')
    expect(new_user.errors.full_messages).to eq(["Email can't be blank"])
  end

  it 'is not valid without a password' do
    new_user = User.create(username: 'Pablo Escobar', email: 'email@mail.com')
    expect(new_user.errors.full_messages).to eq(["Password can't be blank"])
  end

  it "is valid with an admin boolean" do
    expect(admin).to be_valid
  end

  it "defaults to admin => false" do
    expect(user.admin).to eq(false)
  end

  it 'has many accounts' do
    account_1 = user.accounts.build(client: client_1)
    account_2 = user.accounts.build(client: client_2)
    expect(user.accounts.first).to eq(account_1)
    expect(user.accounts.last).to eq(account_2)
  end

  it 'has many invoices through accounts' do
    account_1 = user.accounts.build(name: 'Test Account 1',client: client_1)
    account_2 = user.accounts.build(name: 'Test Account 2',client: client_2)

    user.save

    invoice_1 = account_1.invoices.build(account: account_1, status: 'draft', due_time: (DateTime.now + 7))
    invoice_2 = account_2.invoices.build(account: account_2, status: 'draft', due_time: (DateTime.now + 7))

    account_1.save
    account_2.save

    expect(user.invoices).to include(invoice_1)
    expect(user.invoices).to include(invoice_2)
  end

  it 'has many products through invoices' do
    products = []
    account_1 = user.accounts.build(name: 'Test Account 1',client: client_1)
    account_2 = user.accounts.build(name: 'Test Account 2',client: client_2)

    user.save

    invoice_1 = account_1.invoices.build(account: account_1, status: 'draft', due_time: (DateTime.now + 7))
    invoice_2 = account_2.invoices.build(account: account_2, status: 'draft', due_time: (DateTime.now + 7))

    account_1.save
    account_2.save

    # generate 5 products for each invoice
    products = []
    5.times do
      product_1 = invoice_1.products.build(user: user,name: Faker::Commerce.product_name, price: Faker::Commerce.price, description: 'Product for testing user model relations in test invoice 1')
      product_2 = invoice_2.products.build(user: user,name: Faker::Commerce.product_name, price: Faker::Commerce.price, description: 'Product for testing user model relations in test invoice 2')

      products << product_1
      products << product_2

      invoice_1.save
      invoice_2.save
    end

    expect(user.products).to include(products[0])
    expect(user.products).to include(products[1])
  end

end
