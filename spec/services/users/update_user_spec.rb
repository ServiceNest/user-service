require 'rails_helper'

RSpec.describe Users::UpdateUser do
  let(:repository) { instance_double(Users::UserRepository) }
  let(:service) { described_class.new(user.id, user_params, repository) }
  let(:user) { create(:user) }
  let(:user_params) { { email: 'updated@example.com' } }

  it 'updates a user with valid parameters' do
    allow(repository).to receive(:find).and_return(user)
    allow(repository).to receive(:update).with(user, user_params).and_return(true)

    result = service.call
    expect(result[:user]).to eq(user.reload)
  end

  it 'returns nil if user is not found' do
    allow(repository).to receive(:find).and_return(nil)
    result = service.call
    expect(result).to eq({:status=>:not_found})
  end

  it 'returns false if update fails' do
    invalid_params = { email: nil }
    service_with_invalid_params = described_class.new(user.id, invalid_params, repository)

    allow(repository).to receive(:find).and_return(user)
    allow(repository).to receive(:update).with(user, invalid_params).and_return(false)

    result = service_with_invalid_params.call
    expect(result).to eq({:errors=>[], :status=>:unprocessable_entity})
  end
end