class Link < ApplicationRecord
  acts_as_taggable_on :tags

  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :user }
  validates :url, presence: true
end
