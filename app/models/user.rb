class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_one_attached :avatar

  validates :name, length:{ minimum:2, maximum:20}, uniqueness: true
  validates :introduction, length:{maximum:50}
  validates :email, presence: true


end
