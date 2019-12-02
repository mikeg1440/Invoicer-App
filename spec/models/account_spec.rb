require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:user){
    User.create(
      username: 'rich',
      email: 'rich@mail.com',
      password: 'password'
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
  let(:account_1){
    Account.create(
      user: user,
      client: client_1
    )
  }
  let(:invoice_0){
    account_1.invoices.build(
      status: 'draft',
      due_time: DateTime.now+7
    )
  }

  it 'is valid with a user_id and client_id' do
    expect(Account.create(user: user, client: client_1)).to be_valid
  end

  it 'is not valid without a user_id' do
    expect(Account.create(client: client_1)).to be_invalid
  end

  it 'is not valid without a client_id' do
    account = Account.create(user: user)
    expect(account.errors.full_messages).to include("Client must exist")
  end

  it 'belongs to a user' do
    expect(account_1.user).to eq(user)
  end

  it 'belongs to a client' do
    expect(account_1.client).to eq(client_1)
  end

  it 'has many invoices' do
    invoice_1 = Invoice.create(account_id: account_1.id, status: 'draft', due_time: DateTime.now+7)
    invoice_2 = Invoice.create(account_id: account_1.id, status: 'draft', due_time: DateTime.now+7)

    expect(account_1.invoices.count).to eq(2)
    expect(account_1.invoices.first).to eq(invoice_1)
    expect(account_1.invoices.last).to eq(invoice_2)
  end

  it 'has many products through invoices' do
    products = []

    5.times do
      new_product = invoice_0.products.build(name: Faker::Commerce.product_name, quantity: rand(10), price: Faker::Commerce.price)
      invoice_0.save
      products << new_product
    end

    expect(invoice_0.products.count).to eq(5)
    expect(invoice_0.products).to eq(products)
  end
  # pending "add some examples to (or delete) #{__FILE__}"

end
