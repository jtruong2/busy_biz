require 'rails_helper'

RSpec.configure do |config|
    config.swagger_root = Rails.root.to_s + '/swagger'
  
    config.swagger_docs = {
      'v1/swagger.json' => {
        openapi: '3.0.1',
        info: {
          title: 'API V1',
          version: 'v1',
          description: 'This is the first version of my API'
        },
        servers: [
          {
            url: 'https://{defaultHost}',
            variables: {
              defaultHost: {
                  default: 'www.example.com'
              }
            }
          }
        ]
      }
    }
  end