class Case < ActiveRecord::Base
  belongs_to :user

  scope :published, -> { where(is_published: true) }
end
