class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_images, dependent: :destroy
  accepts_nested_attributes_for :post_images, allow_destroy: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end


end
