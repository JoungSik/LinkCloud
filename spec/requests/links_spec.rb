require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "Links API", type: :request do
  before(:each) do
    @user = FactoryBot.create(:user)
    @link = FactoryBot.create(:link, user_id: @user.id)

    @headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    @auth_headers = Devise::JWT::TestHelpers.auth_headers(@headers, @user)
  end

  path '/links' do
    get 'GET Links' do
      tags 'Link'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, required: true, description: 'Bearer {key}'

      response '200', '성공' do
        let(:'Authorization') { @auth_headers['Authorization'] }
        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body).size).to eql @user.links.size
        end
      end

      response '401', '실패' do
        let(:'Authorization') { '' }
        run_test!
      end
    end

    post 'CREATE Links' do
      tags 'Link'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, required: true, description: 'Bearer {key}'
      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: "구글" },
          url: { type: :string, example: "https://google.com" },
          tag_list: { type: :string, example: "개발자" },
        },
        required: %w[name url]
      }

      response '201', '성공' do
        let(:'Authorization') { @auth_headers['Authorization'] }
        let(:body) { { name: "구글", url: "https://google.com", tag_list: "개발자, FE" } }
        run_test! do |response|
          expect(response).to have_http_status(:created)
        end
      end

      response '401', '인증 실패' do
        let(:'Authorization') { '' }
        run_test!
      end

      response '422', '파라메터 부족으로 실패' do
        let(:'Authorization') { @auth_headers['Authorization'] }
        let(:body) { { name: "example", url: "https://google.com", tag_list: "개발자, FE" } }
        run_test! do |response|
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  path '/links/{id}' do
    get 'GET Link' do
      tags 'Link'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, required: true, description: 'Bearer {key}'
      parameter name: :id, in: :path, type: :string

      response '200', '성공' do
        let(:'Authorization') { @auth_headers['Authorization'] }
        let(:id) { @link.id }
        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)).to eql @link.as_json
        end
      end

      response '401', '인증 실패' do
        let(:'Authorization') { '' }
        let(:id) { @link.id }
        run_test!
      end

      response '404', '링크 찾기 실패' do
        let(:'Authorization') { @auth_headers['Authorization'] }
        let(:id) { '999999' }
        run_test!
      end
    end

    patch 'UPDATE Link' do
      tags 'Link'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, required: true, description: 'Bearer {key}'
      parameter name: :id, in: :path, type: :string
      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: "구글" },
          url: { type: :string, example: "https://google.com" },
          tag_list: { type: :string, example: "개발자" },
        },
        required: %w[name url]
      }

      response '200', '성공' do
        let(:'Authorization') { @auth_headers['Authorization'] }
        let(:id) { @link.id }
        let(:body) { { name: "네이버", url: "https://naver.com" } }
        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)['url']).to match('https://naver.com')
        end
      end

      response '401', '인증 실패' do
        let(:'Authorization') { '' }
        let(:id) { @link.id }
        run_test!
      end

      response '404', '링크 찾기 실패' do
        let(:'Authorization') { @auth_headers['Authorization'] }
        let(:id) { '999999' }
        let(:body) { { name: "구글", url: "https://google.com", tag_list: "개발자" } }
        run_test!
      end
    end

    delete 'DELETE Link' do
      tags 'Link'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, required: true, description: 'Bearer {key}'
      parameter name: :id, in: :path, type: :string

      response '204', '성공' do
        let(:'Authorization') { @auth_headers['Authorization'] }
        let(:id) { @link.id }
        run_test! do |response|
          expect(response).to have_http_status(:no_content)
        end
      end

      response '401', '인증 실패' do
        let(:'Authorization') { '' }
        let(:id) { @link.id }
        run_test!
      end

      response '404', '링크 찾기 실패' do
        let(:'Authorization') { @auth_headers['Authorization'] }
        let(:id) { '999999' }
        run_test!
      end
    end
  end
end
