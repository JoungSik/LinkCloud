class Link < ApplicationRecord
  acts_as_taggable_on :tags

  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :user }
  validates :url, presence: true

  def as_json(options = {})
    super(options)
      .merge(
        { 'created_at' => created_at.strftime('%Y-%m-%d'),
          'updated_at' => updated_at.strftime('%Y-%m-%d')
        }
      )
  end
end
