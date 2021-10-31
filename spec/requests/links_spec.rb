require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Links API', type: :request do
  before(:each) do
    @user = FactoryBot.create(:user)
    @link = FactoryBot.create(:link, user_id: @user.id)
    @update_link = FactoryBot.create(:link, user_id: @user.id, name: 'example2')

    @headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    @auth_headers = Devise::JWT::TestHelpers.auth_headers(@headers, @user)
  end

  path '/links' do
    get 'GET Links' do
      tags 'Link'
      consumes 'application/json'
      produces 'application/json'
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
        run_test! do |response|
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

    post 'CREATE Links' do
      tags 'Link'
      consumes 'application/json'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, required: true, description: 'Bearer {key}'
      parameter name: :body, in: :body, schema: { '$ref' => '#/components/schemas/link' }

      response '201', '성공' do
        let(:'Authorization') { @auth_headers['Authorization'] }
        let!(:body) { { link: { name: '구글', url: 'https://google.com', tag_list: '개발자, FE' } } }
        run_test! do |response|
          expect(response).to have_http_status(:created)
        end
      end

      response '401', '인증 실패' do
        let(:'Authorization') { '' }
        run_test! do |response|
          expect(response).to have_http_status(:unauthorized)
        end
      end

      response '422', '실패 - 중복 값' do
        let(:'Authorization') { @auth_headers['Authorization'] }
        let(:body) { { name: @link.name } }
        run_test! do |response|
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      response '422', '실패 - 값 부족' do
        let(:'Authorization') { @auth_headers['Authorization'] }
        let(:body) { { name: 'example3' } }
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
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, required: true, description: 'Bearer {key}'
      parameter name: :id, in: :path, type: :string

      response '200', '성공' do
        let(:'Authorization') { @auth_headers['Authorization'] }
        let(:id) { @link.id }
        run_test! do |response|
          expect(response).to have_http_status(:ok)
          json = JSON.parse(response.body)
          expect(json['id']).to eql @link.id
        end
      end

      response '401', '인증 실패' do
        let(:'Authorization') { '' }
        let(:id) { @link.id }
        run_test! do |response|
          expect(response).to have_http_status(:unauthorized)
        end
      end

      response '404', '링크 찾기 실패' do
        let(:'Authorization') { @auth_headers['Authorization'] }
        let(:id) { '999999' }
        run_test! do |response|
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    patch 'UPDATE Link' do
      tags 'Link'
      consumes 'application/json'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, required: true, description: 'Bearer {key}'
      parameter name: :id, in: :path, type: :string
      parameter name: :body, in: :body, schema: { '$ref' => '#/components/schemas/link' }

      response '200', '성공' do
        let(:'Authorization') { @auth_headers['Authorization'] }
        let(:id) { @link.id }
        let(:body) { { name: '네이버', url: 'https://naver.com' } }
        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)['url']).to match('https://naver.com')
        end
      end

      response '401', '인증 실패' do
        let(:'Authorization') { '' }
        let(:id) { @link.id }
        run_test! do |response|
          expect(response).to have_http_status(:unauthorized)
        end
      end

      response '404', '링크 찾기 실패' do
        let(:'Authorization') { @auth_headers['Authorization'] }
        let(:id) { '999999' }
        let(:body) { { name: '구글', url: 'https://google.com', tag_list: '개발자' } }
        run_test! do |response|
          expect(response).to have_http_status(:not_found)
        end
      end

      response '422', '업데이트 실패 - 중복 값' do
        let(:'Authorization') { @auth_headers['Authorization'] }
        let(:id) { @update_link.id }
        let(:body) { { name: 'example' } }
        run_test! do |response|
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    delete 'DELETE Link' do
      tags 'Link'
      produces 'application/json'
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
        run_test! do |response|
          expect(response).to have_http_status(:unauthorized)
        end
      end

      response '404', '링크 찾기 실패' do
        let(:'Authorization') { @auth_headers['Authorization'] }
        let(:id) { '999999' }
        run_test! do |response|
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
