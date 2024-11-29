require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  describe 'GET #index' do
    it 'returns a list of users' do
      create_list(:user, 3) do |user, i|
        user.update(email: "user#{i}@example.com")
      end

      get :index

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(3)
    end
  end

  describe 'GET #show' do
    it 'returns the user details' do
      user = create(:user)
      get :show, params: { id: user.id }

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['email']).to eq(user.email)
      expect(json_response['role']).to eq(user.role)
      expect(json_response['name']).to eq(user.name)
      expect(json_response['lastname']).to eq(user.lastname)
      expect(json_response['phone']).to eq(user.phone)
    end

    it 'returns an error if the user is not found' do
      get :show, params: { id: 0 }

      expect(response).to have_http_status(:not_found)
      json_response = JSON.parse(response.body)
      expect(json_response).to have_key('errors')
      expect(json_response['errors']).to eq('User not found')
    end
  end

  describe 'POST #create' do
    it 'creates a new user with valid parameters' do
      post :create, params: {
        user: {
          email: 'newuser@example.com',
          password: 'password',
          role: 'client',
          name: 'New User',
          lastname: 'Lastname',
          phone: '1234567890'
        }
      }

      expect(response).to have_http_status(:created)

      json_response = JSON.parse(response.body)
      expect(json_response['email']).to eq('newuser@example.com')
      expect(json_response['role']).to eq('client')
      expect(json_response['name']).to eq('New User')
      expect(json_response['lastname']).to eq('Lastname')
      expect(json_response['phone']).to eq('1234567890')
    end

    it 'returns an error with invalid parameters' do
      post :create, params: {
        user: {
          email: '',
          password: 'password',
          role: 'client',
          name: 'New User',
          lastname: 'Lastname',
          phone: '1234567890'
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)
      expect(json_response).to have_key('errors')
    end
  end

  describe 'PATCH #update' do
    let(:user) { create(:user) }

    it 'updates the user with valid parameters' do
      patch :update, params: {
        id: user.id,
        user: {
          email: 'updatedemail@example.com'
        }
      }

      expect(response).to have_http_status(:ok)
      user.reload
      expect(user.email).to eq('updatedemail@example.com')
    end

    it 'returns an error with invalid parameters' do
      patch :update, params: {
        id: user.id,
        user: {
          email: ''
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
      json_response = JSON.parse(response.body)
      expect(json_response).to have_key('errors')
      expect(json_response['errors']).to eq(["Email can't be blank", "Email is invalid"])
    end

    it 'returns an error if the user is not found' do
      patch :update, params: {
        id: 0,
        user: {
          email: 'updatedemail@example.com'
        }
      }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }

    it 'deletes the user' do
      delete :destroy, params: { id: user.id }

      expect(response).to have_http_status(:no_content)
      expect { user.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'returns an error if the user is not found' do
      delete :destroy, params: { id: 0 }

      expect(response).to have_http_status(:not_found)
    end
  end
end