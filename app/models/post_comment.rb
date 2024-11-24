class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true, length: { maximum: 300 } # 最大文字数を制限
end
