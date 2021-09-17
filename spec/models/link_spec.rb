require 'rails_helper'

RSpec.describe Link, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
    @link = FactoryBot.create(:link, user_id: @user.id)
  end

  describe 'validate' do
    it 'Name already' do
      link = Link.create({ name: @link.name, url: @link.url, user_id: @user.id })
      link.validate
      expect(link.errors.full_messages).to include("Name has already been taken")
    end
  end
end
