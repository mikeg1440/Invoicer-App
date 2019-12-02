require 'rails_helper'

RSpec.describe Client, type: :model do

  let(:user_1){
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
      user: user_1,
      client: client_1
    )
  }
  let(:invoice_0){
    account_1.invoices.build(
      status: 'draft',
      due_time: DateTime.now+7
    )
  }

  it 'is valid with name and email' do
    expect(Client.create(name: 'Steve Jobs', email: 'steveyJ@apple.com')).to be_valid
  end

  it 'is not valid without a name' do
    # binding.pry
    expect(Client.new(email: 'steveyJ@apple.com', business_name: 'Apple Inc')).to_not be_valid
  end

  it 'is not valid without a email' do
    expect(Client.new(name: 'steve jobs', business_name: 'Apple Inc')).to_not be_valid
  end

  it 'belongs to a account' do
    expect(client_1.accounts).to include(account_1)
  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
