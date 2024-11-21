class Post < ApplicationRecord
  belongs_to :user

  has_many :post_comments, dependent: :destroy

  validates :content, length:{maximum:200},presence: true

  def comments_count
    post_comments.count
  end
end
