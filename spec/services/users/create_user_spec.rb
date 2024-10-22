require 'rails_helper'

RSpec.describe Users::CreateUser do
  it 'creates a new user with valid parameters' do
    service = Users::CreateUser.new(
      email: 'newuser@example.com',
      password: 'password',
      role: 'client',
      name: 'New User',
      lastname: 'Lastname',
      phone: '1234567890'
    )

    user = service.call

    expect(user).to be_persisted
    expect(user.email).to eq('newuser@example.com')
  end

  it 'raises an error with invalid parameters' do
    service = Users::CreateUser.new(
      email: '',
      password: 'password',
      role: 'client',
      name: 'New User',
      lastname: 'Lastname',
      phone: '1234567890'
    )

    expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
  end
end