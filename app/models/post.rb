class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  acts_as_taggable
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_images, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(search, keyword)
    if search == "forward_match"
      @posts = post.where("title LIKE?","#{keyword}%")
    elsif search == "backward_match"
      @posts = post.where("title LIKE?","%#{keyword}")
    elsif search == "perfect_match"
      @posts = post.where(title:keyword)
    elsif search == "partial_match"
      @posts = post.where("title LIKE?","%#{keyword}%")
    else
      @posts = post.all
    end
  end


end
