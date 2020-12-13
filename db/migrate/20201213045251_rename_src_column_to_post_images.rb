class RenameSrcColumnToPostImages < ActiveRecord::Migration[5.2]
  def change
    rename_column :post_images, :src, :image_id
  end
end
