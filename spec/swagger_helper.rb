require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.to_s + '/swagger'

  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1',
        description: 'Documentación de la API'
      },
      paths: {},
      servers: [
        {
          url: 'http://localhost:3000',
          description: 'Servidor de desarrollo'
        }
      ]
    }
  }

  config.swagger_format = :yaml
end