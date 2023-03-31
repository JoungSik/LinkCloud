class Link < ApplicationRecord
  belongs_to :user

  has_many :taggings, :dependent => :destroy
  has_many :tags, through: :taggings
  accepts_nested_attributes_for :taggings

  validates_presence_of :name, :url, :user
  validates_uniqueness_of :name, scope: :user_id
  validates_uniqueness_of :url, scope: :user_id
end
