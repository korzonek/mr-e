class Mystery < ActiveRecord::Base
  belongs_to :admin, class_name: User, foreign_key: 'user_id'
  has_many :participants
  has_many :users, through: :participants

  scope :published, -> { where(is_published: true) }

  validates :name, :description, presence: true
end
