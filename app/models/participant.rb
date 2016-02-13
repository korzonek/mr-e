class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :mystery

  validates :user, uniqueness: { scope: :mystery, message: 'should not be duplicated' }
end
