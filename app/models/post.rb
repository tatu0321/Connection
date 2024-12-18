class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre

  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  validates :content, length:{maximum:200},presence: true
  validates :genre_id, presence: true

  def comments_count
    post_comments.count
  end
end
