require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do
  path '/api/v1/users' do
    get 'Retrieve all users' do
      tags 'Users'
      produces 'application/json'

      response '200', 'users retrieved' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   email: { type: :string },
                   name: { type: :string },
                   lastname: { type: :string },
                   phone: { type: :string },
                   role: { type: :string },
                   created_at: { type: :string }
                 },
                 required: %w[id email name lastname role]
               }

        before do
          create_list(:user, 3) do |user, i|
            user.update(email: "user#{i}@example.com")
          end
        end

        run_test!
      end
    end

    post 'Create a new user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string },
              name: { type: :string },
              lastname: { type: :string },
              role: { type: :string },
              phone: { type: :string }
            },
            required: %w[email password name lastname role phone]
          }
        }
      }

      response '201', 'user created' do
        let(:user) do
          {
            user: {
              email: 'newuser@example.com',
              password: 'password123',
              name: 'New',
              lastname: 'User',
              role: 'client',
              phone: '1234567890'
            }
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['email']).to eq(user[:user][:email])
        end
      end

      response '422', 'invalid request' do
        let(:user) { { email: '' } }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do
    get 'Retrieve a specific user' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'ID of the user'

      response '200', 'user retrieved' do
        let(:id) { create(:user).id }

        schema type: :object,
               properties: {
                 id: { type: :integer },
                 email: { type: :string },
                 name: { type: :string },
                 lastname: { type: :string },
                 role: { type: :string }
               },
               required: %w[id email name lastname role]

        run_test!
      end

      response '404', 'user not found' do
        let(:id) { -1 }
        run_test!
      end
    end

    patch 'Update a specific user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'ID of the user'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          name: { type: :string },
          lastname: { type: :string },
          role: { type: :string },
          phone: { type: :string }
        },
        required: []
      }

      response '200', 'user updated' do
        let(:id) { create(:user).id }
        let(:user) do
          {
            email: 'updated@example.com',
            name: 'Updated',
            lastname: 'User',
            role: 'client'
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['email']).to eq(user[:email])
        end
      end

      response '404', 'user not found' do
        let(:id) { -1 }
        let(:user) do
          {
            email: 'updated@example.com',
            name: 'Updated',
            lastname: 'User',
            role: 'client'
          }
        end
        run_test!
      end

      response '422', 'invalid parameters' do
        let(:id) { create(:user).id }
        let(:user) { { email: '' } }
        run_test!
      end
    end

    delete 'Delete a specific user' do
      tags 'Users'
      parameter name: :id, in: :path, type: :integer, description: 'ID of the user'

      response '204', 'user deleted' do
        let(:id) { create(:user).id }
        run_test!
      end

      response '404', 'user not found' do
        let(:id) { -1 }
        run_test!
      end
    end
  end
end
