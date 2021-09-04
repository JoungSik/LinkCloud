class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :email
  attribute :created_at do |user|
    user.created_at.strftime('%Y-%m-%d')
  end
end
