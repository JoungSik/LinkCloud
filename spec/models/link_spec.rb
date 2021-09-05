require 'rails_helper'

RSpec.describe Link, type: :model do

  describe 'validate' do
    it 'Name already' do
      user = User.first
      record1 = Link.create(user_id: user.id, name: "구글", url: "https://google.com")
      record2 = Link.create(user_id: user.id, name: "구글", url: "https://google.com")

      record2.validate
      expect(record2.errors.full_messages).to include("Name has already been taken")

    end
  end
end
