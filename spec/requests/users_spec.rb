require 'rails_helper'
require 'swagger_helper'

describe 'Users API' do
  before(:each) do
    FactoryBot.create(:user, password: 'qwer1234')
  end

  path '/users' do
    post 'Register' do
      tags 'User'
      consumes 'application/json'
      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: '김정식' },
          email: { type: :string, example: 'tjstlr2010@gmail.com' },
          password: { type: :string, example: 'qwer1234' }
        },
        required: %w[name email password]
      }

      response '201', '회원가입 성공' do
        let(:body) { { name: '김정식', email: 'example2@example.com', password: 'qwer1234' } }
        run_test! do |response|
          expect(response).to have_http_status(:created)
        end
      end

      response '400', '회원가입 실패 - 파라메터 부족' do
        let(:body) { { email: 'example2@example.com', password: 'qwer1234' } }
        run_test! do |response|
          expect(response).to have_http_status(:bad_request)
        end
      end
    end
  end

  path '/login' do
    post 'Login' do
      tags 'User'
      consumes 'application/json'
      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, example: 'tjstlr2010@gmail.com' },
          password: { type: :string, example: 'qwer1234' }
        },
        required: %w[email password]
      }

      response '200', '로그인 성공', save_request_example: :valid_body do
        let(:body) { { email: 'example@example.com', password: 'qwer1234' } }
        run_test! do |response|
          expect(response).to have_http_status(:ok)
        end
      end

      response '401', '로그인 실패' do
        let(:body) { { email: 'example@example.com', password: 'qwer' } }
        run_test! do |response|
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end