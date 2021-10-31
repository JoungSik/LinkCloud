require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Links API', type: :request do
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
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, required: true, description: 'Bearer {key}'

      response '200', '성공' do
        let(:'Authorization') { @auth_headers['Authorization'] }
        run_test! do |response|
          json = JSON.parse(response.body, symbolize_names: true)
          expect(response).to have_http_status(:ok)
          json.each do |link|
            expect(link.keys).to include(:id, :name, :url, :description)
          end
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
        let!(:body) { { link: { name: '구글', url: 'https://google.com', description: '구글 홈페이지', tag_list: '개발자, FE' } } }
        run_test! do |response|
          json = JSON.parse(response.body, symbolize_names: true)
          expect(response).to have_http_status(:created)
          expect(json.keys).to include(:id, :name, :url, :description)
          expect(json[:name]).to eq '구글'
          expect(json[:url]).to eq 'https://google.com'
          expect(json[:description]).to eq '구글 홈페이지'
          expect(json[:tag_list]).to eq %w[개발자 FE]
        end
      end

      response '401', '인증 실패' do
        let(:'Authorization') { '' }
        run_test! do |response|
          expect(response).to have_http_status(:unauthorized)
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
          json = JSON.parse(response.body, symbolize_names: true)
          expect(response).to have_http_status(:ok)
          expect(json.keys).to include(:id, :name, :url, :description)
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
          json = JSON.parse(response.body, symbolize_names: true)
          expect(response).to have_http_status(:ok)
          expect(json.keys).to include(:id, :name, :url, :description)
          expect(json[:name]).to eq '네이버'
          expect(json[:url]).to eq 'https://naver.com'
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
