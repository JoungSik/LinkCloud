class Link < ApplicationRecord
  belongs_to :user

  validates_uniqueness_of :name

  def as_json(options = {})
    super(options)
      .merge(
        { 'created_at' => created_at.strftime('%Y-%m-%d'),
          'updated_at' => updated_at.strftime('%Y-%m-%d')
        }
      )
  end
end
