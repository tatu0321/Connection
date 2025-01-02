class UserRoom < ApplicationRecord

  #DM機能
  belongs_to :user
  belongs_to :room
end
