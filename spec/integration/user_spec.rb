require 'swagger_helper'

describe 'Users API' do

  path '/users' do

    post 'Registers a user and retrieves a Bearer token' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          password: { type: :string }
        },
        required: [ 'username', 'password' ]
      }

      response '200', 'User created' do
        let(:user) { { username: 'foo', token: 'xxxxxxxxxxxxxxxxx' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { message: 'Invalid username or password' } }
        run_test!
      end
    end
  end

  path '/users/refresh-token' do

    post 'Creates a new Bearer token' do
      tags 'Users'
      produces 'application/json', 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          password: { type: :string }
        },
        required: [ 'username', 'password' ]
      }

      response '200', 'Token created' do
        let(:user) { { username: 'foo', token: 'xxxxxxxxxxxxxxxxx' } }
        run_test!
      end

      response '401', 'unauthorized' do
        let(:user) { { message: 'Invalid username or password' } }
        run_test!
      end
    end
  end
end