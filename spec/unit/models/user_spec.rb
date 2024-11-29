require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user = build(:user, email: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid with an invalid role' do
      user = build(:user, role: 'invalid')
      expect(user).to_not be_valid
    end

    it 'is not valid without a name' do
      user = build(:user, name: nil)
      expect(user).to_not be_valid
      expect(user.errors.messages[:name]).to include("can't be blank")
    end

    it 'is not valid without a lastname' do
      user = build(:user, lastname: nil)
      expect(user).to_not be_valid
      expect(user.errors.messages[:lastname]).to include("can't be blank")
    end

    it 'is not valid without a phone' do
      user = build(:user, phone: nil)
      expect(user).to_not be_valid
      expect(user.errors.messages[:phone]).to include("can't be blank")
    end

    it 'is not valid with a duplicated email' do
      create(:user, email: 'example@mail.com')
      user = build(:user, email: 'example@mail.com')
      expect(user).to_not be_valid
      expect(user.errors.messages[:email]).to include('has already been taken')
    end

    it 'is not valid with an invalid email' do
      user = build(:user, email: 'invalid')
      expect(user).to_not be_valid
      expect(user.errors.messages[:email]).to include('is invalid')
    end

    it 'is not valid with a short password' do
      user = build(:user, password: 's')
      expect(user).to_not be_valid
      expect(user.errors.messages[:password]).to include('is too short (minimum is 8 characters)')
    end

    it 'is not valid with a long password' do
      user = build(:user, password: 'a' * 129)
      expect(user).to_not be_valid
      expect(user.errors.messages[:password]).to include('is too long (maximum is 128 characters)')
    end

    it 'is not valid with an invalid phone' do
      user = build(:user, phone: 'invalid')
      expect(user).to_not be_valid
      expect(user.errors.messages[:phone]).to include('must be a valid phone')
    end

    it 'is not valid with a short phone' do
      user = build(:user, phone: '123')
      expect(user).to_not be_valid
      expect(user.errors.messages[:phone]).to include('must be a valid phone')
    end

    it 'is not valid with a long phone' do
      user = build(:user, phone: '1' * 21)
      expect(user).to_not be_valid
      expect(user.errors.messages[:phone]).to include('must be a valid phone')
    end
  end
end