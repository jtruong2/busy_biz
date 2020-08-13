require 'swagger_helper'

describe 'Search API' do

  path '/businesses' do

    get 'Retrieves all search terms by current user' do
      tags 'Search'
      produces 'application/json', 'application/json'
      security [api_key: []]
    #   parameter name: :Authorization, 
    #     in: :header, required: true, 
    #     description: "Registered user's bearer token", 
    #     schema: { type: :string }
      response '200', 'searches found' do
        let(:Authorization) { "Bearer BEARER_TOKEN" }
        schema type: :array,
        items: {type: :string}
        run_test!
      end

      response '401', 'authentication failed' do
        let(:Authorization) { "Bearer notarealtoken" }
        run_test!
      end
    end
  end
end