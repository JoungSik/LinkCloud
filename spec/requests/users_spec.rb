require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:valid_attributes) {
    {
      "user": {
        email: "example@example.com",
        password: "qwer1234"
      }
    }
  }

  let(:invalid_attributes) {
    {
      "user": {
        email: "example@example.com",
        password: "password"
      }
    }
  }

  describe "POST /login" do
    it "Login" do
      post user_session_url, params: valid_attributes
      expect(response).to have_http_status(200)
    end

    it "Login Error" do
      post user_session_url, params: invalid_attributes
      expect(response).to have_http_status(401)
    end
  end
end
