class Room < ApplicationRecord

  #DM機能
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
end
