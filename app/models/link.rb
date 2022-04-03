class Link < ApplicationRecord
  belongs_to :user

  validates_uniqueness_of :name, scope: :user_id
  validates_uniqueness_of :url, scope: :user_id
end
