class PostImage < ApplicationRecord
  mount_uploader :src, ImageUploader
  belongs_to :post, optional: true

  # validates :src, presence: true
end
