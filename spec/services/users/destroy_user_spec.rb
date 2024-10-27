require 'rails_helper'

RSpec.describe Users::DestroyUser do
  let(:repository) { instance_double(Users::UserRepository) }
  let(:service) { described_class.new(user.id, repository) }
  let(:user) { User.new(id: 1, email: 'test@example.com', password: 'password123', role: 'client') }

  it 'deletes a user if found' do
    allow(repository).to receive(:find).and_return(user)
    allow(repository).to receive(:destroy).and_return(user)

    result = service.call
    expect(result).to eq(user)
  end

  it 'returns nil if user is not found' do
    allow(repository).to receive(:find).and_return(nil)

    result = service.call
    expect(result).to be_nil
  end
end