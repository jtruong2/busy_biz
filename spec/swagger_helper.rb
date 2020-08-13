require 'rails_helper'

RSpec.configure do |config|
    config.swagger_root = Rails.root.to_s + '/swagger'
  
    config.swagger_docs = {
      'v1/swagger.json' => {
        openapi: '3.0.1',
        info: {
            title: 'Busy Biz API V1',
            version: 'v1',
            description: 'Search for businesses across the world. Get reviews, addresss, phone numbers, and more!'
        },
        components: {
            securitySchemes: {
              api_key: {
                type: :apiKey,
                name: 'Authorization',
                description: "Bearer token received from POST /users",
                in: :header
              }
            }
        },
        servers: [
          {
            url: 'http://localhost:3000/api/v1',
            variables: {
                defaultHost: {
                    default: 'localhost:3000'
                }
            }
          }
        ]
      }
    }
  end