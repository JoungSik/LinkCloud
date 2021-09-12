require 'rails_helper'
require 'swagger_helper'

describe 'Users API' do
  path '/login' do
    post 'Login' do
      tags 'user'
      consumes 'application/json'
      parameter name: :session, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, example: "tjstlr2010@gmail.com" },
          password: { type: :string, example: "qwer1234" }
        },
        required: %w[email password]
      }

      response :ok, 'Login successful' do
        run_test!
      end

      response :unauthorized, 'Login error' do
        run_test!
      end
    end
  end
end