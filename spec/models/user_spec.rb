require "rails_helper"

RSpec.describe User, type: :model do

  let(:user){
    User.create(
      username: 'rich',
      email: 'rich@mail.com',
      password: 'password'
    )
  }
  
  it 'It is valid with a username, email and password' do
    expect(user).to be_valid
  end
end
