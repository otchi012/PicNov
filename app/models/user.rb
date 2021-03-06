class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post # ランキング機能
  has_many :post_comments, dependent: :destroy

  has_many :active_relationships, class_name:
    "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name:
    "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  attachment :profile_image

  # ユーザーをフォローする
  def follow(user_id)
    active_relationships.create(followed_id: user_id)
  end

  # ユーザーをフォロー解除する
  def unfollow(user_id)
    active_relationships.find_by(followed_id: user_id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(user)
    following.include?(user)
  end

  def self.search(keyword)
    #部分一致のみの検索機能
    return User.all unless keyword
    User.where("name LIKE?", "%#{keyword}%")
  end
end
