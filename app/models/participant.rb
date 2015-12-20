class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :case

  validates :user, uniqueness: { scope: :case, message: 'should not be duplicated' }
end
