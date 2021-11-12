class Link < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :user }
  validates :url, presence: true
end
