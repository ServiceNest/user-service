require 'rails_helper'

RSpec.describe Users::UserRepository, type: :repository do
  let(:repository) { described_class.new }

  describe '#create!' do
    it 'creates a new user with valid parameters' do
      user = repository.create(
        email: 'newuser@example.com',
        password: 'password',
        role: 'client',
        name: 'New User',
        lastname: 'Lastname',
        phone: '1234567890'
      )

      expect(user).to be_persisted
      expect(user.email).to eq('newuser@example.com')
    end
  end

  describe '#find' do
    it 'finds a user by id' do
      user = create(:user)

      expect(repository.find(user.id)).to eq(user)
    end
  end

  describe '#update' do
    it 'updates an existing user' do
      user = create(:user)

      repository.update(user, email: 'newmail@example.com')
      expect(user.reload.email).to eq('newmail@example.com')
    end
  end

  describe '#destroy' do
    it 'deletes a user' do
      user = create(:user)
      repository.destroy(user)
      expect(User.find_by(id: user.id)).to be_nil
    end
  end
end