require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
  end

  describe 'validate' do
    it 'Email has already been taken' do
      user = User.create({ email: @user.email, name: "example2", password: @user.password })
      user.validate
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it 'Name has already been taken' do
      user = User.create({ email: "example2@example.com", name: @user.name, password: @user.password })
      user.validate
      expect(user.errors.full_messages).to include("Name has already been taken")
    end
  end
end
