class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :links, dependent: :delete_all

  validates :name, presence: true, uniqueness: true

  def as_json(options = {})
    super(options)
      .merge(
        { 'created_at' => created_at.strftime('%Y-%m-%d'),
          'updated_at' => updated_at.strftime('%Y-%m-%d')
        }
      )
  end
end
