class Request < ActiveRecord::Base
  belongs_to :user
  belongs_to :mystery
end
