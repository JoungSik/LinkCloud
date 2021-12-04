class Link < ApplicationRecord
  Gutentag::ActiveRecord.call self

  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :user }
  validates :url, presence: true

  def tags_as_string=(string)
    self.tag_names = string.split(/,\s*/)
  end
end
