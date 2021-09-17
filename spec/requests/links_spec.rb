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

  # describe "GET /index" do
  #   it "renders a successful response" do
  #     get "/links", headers: @auth_headers, as: :json
  #     expect(response).to have_http_status(:ok)
  #     expect(JSON.parse(response.body).size).to eql @user.links.size
  #   end
  # end
  #
  # describe "GET /show" do
  #   it "renders a successful response" do
  #     get "/links/#{@link.id}", headers: @auth_headers, as: :json
  #     expect(response).to have_http_status(:ok)
  #     expect(JSON.parse(response.body)).to eq @link.as_json
  #   end
  # end
  #
  # describe "POST /create" do
  #   context "with valid parameters" do
  #     it "renders a JSON response with the new link" do
  #       post links_url, params: { link: valid_attributes }, headers: @auth_headers, as: :json
  #       expect(response).to have_http_status(:created)
  #     end
  #
  #     it "renders a JSON response with the new link with tag list" do
  #       post links_url, params: { link: valid_attributes }, headers: @auth_headers, as: :json
  #       json = JSON.parse(response.body)
  #       expect(json["tag_list"]).not_to be_blank
  #       expect(response).to have_http_status(:created)
  #     end
  #   end
  #
  #   context "with invalid parameters" do
  #     it "does not create a new Link" do
  #       expect { post links_url, params: { link: invalid_attributes }, as: :json }.to change(Link, :count).by(0)
  #     end
  #
  #     it "renders a JSON response with errors for the new link" do
  #       post links_url, params: { link: invalid_attributes }, headers: @auth_headers, as: :json
  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end
  #   end
  # end
  #
  # describe "PATCH /update" do
  #   context "with valid parameters" do
  #     link = Link.first
  #
  #     let(:new_attributes) {
  #       {
  #         name: "google",
  #         url: "https://www.google.com",
  #         tag_list: "온라인"
  #       }
  #     }
  #
  #     it "renders a JSON response with the link" do
  #       patch "/links/#{link.id}", params: { link: new_attributes }, headers: @auth_headers, as: :json
  #       json = JSON.parse(response.body)
  #       expect(json["tag_list"]).to eq(["온라인"])
  #       expect(response).to have_http_status(:ok)
  #     end
  #   end
  #
  #   context "with invalid parameters" do
  #     link = Link.first
  #
  #     let(:invalid_attributes) {
  #       {
  #         name: "daum",
  #         url: "https://www.daum.net",
  #         tag_list: "온라인, 웹사이트"
  #       }
  #     }
  #
  #     it "renders a JSON response with errors for the link" do
  #       patch "/links/#{link.id}", params: { link: invalid_attributes }, headers: @auth_headers, as: :json
  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end
  #   end
  # end
  #
  # describe "DELETE /destroy" do
  #   it "destroys the requested link" do
  #     expect { delete "/links/#{link.id}", headers: @auth_headers, as: :json }.to change(Link, :count).by(-1)
  #   end
  # end
end
