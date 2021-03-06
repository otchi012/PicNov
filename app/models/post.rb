class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  acts_as_taggable
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user # ランキング機能
  has_many :post_comments, dependent: :destroy
  has_many :post_images, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(keyword)
    #部分一致のみの検索機能
    return Post.all unless keyword
    Post.where("title LIKE?", "%#{keyword}%")
  end
end
