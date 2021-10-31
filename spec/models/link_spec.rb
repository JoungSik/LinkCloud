require 'rails_helper'

RSpec.describe Link, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
    @link = FactoryBot.create(:link, user_id: @user.id)
  end
end
