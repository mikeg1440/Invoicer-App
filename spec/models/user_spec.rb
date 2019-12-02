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


  it 'is valid with a username, email and password' do
    expect(user).to be_valid
  end

  # it 'is not valid without a username' do
  #   expect(User.new(email: 'email@mail.com', password: 'password')).not_to be_valid
  # end

  it 'is not valid without a password' do
    expect(User.new(username: 'Name', email: 'email@mail.com')).not_to be_valid
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

end
