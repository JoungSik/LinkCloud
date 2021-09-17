require 'rails_helper'
require 'swagger_helper'

describe 'Users API' do
  before(:each) do
    FactoryBot.create(:user, password: 'qwer1234')
  end

  path '/login' do
    post 'Login' do
      tags 'User'
      consumes 'application/json'
      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, example: "tjstlr2010@gmail.com" },
          password: { type: :string, example: "qwer1234" }
        },
        required: %w[email password]
      }

      response '200', '로그인 성공' do
        let(:body) { { email: "example@example.com", password: 'qwer1234' } }
        run_test!
      end

      response '401', '로그인 실패' do
        let(:body) { { email: 'example@example.com', password: 'qwer' } }
        run_test!
      end
    end
  end
end