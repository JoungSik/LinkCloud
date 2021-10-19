require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
  end

  describe 'validate' do
    it 'Email has already been taken' do
      user = User.create({ email: @user.email, name: "example2", password: @user.password })
      user.validate
      expect(user.errors.messages[:email]).to include I18n.t('activerecord.errors.messages.taken')
    end

    it 'Name has already been taken' do
      user = User.create({ email: "example2@example.com", name: @user.name, password: @user.password })
      user.validate
      expect(user.errors.messages[:name]).to include I18n.t('activerecord.errors.messages.taken')
    end
  end
end
