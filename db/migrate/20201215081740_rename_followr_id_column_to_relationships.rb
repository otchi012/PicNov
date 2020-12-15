class RenameFollowrIdColumnToRelationships < ActiveRecord::Migration[5.2]
  def change
    rename_column :relationships, :followr_id, :follower_id
  end
end
