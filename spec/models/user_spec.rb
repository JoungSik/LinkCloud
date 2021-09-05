require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validate' do
    it 'Email has already been taken' do
      record = User.create(name: "example", email: "example@example.com", password: "qwer1234")
      record.validate
      expect(record.errors.full_messages).to include("Email has already been taken")
    end

    it 'Name has already been taken' do
      record = User.create(name: "example", email: "example@example.com", password: "qwer1234")
      record.validate
      expect(record.errors.full_messages).to include("Name has already been taken")
    end
  end
end
