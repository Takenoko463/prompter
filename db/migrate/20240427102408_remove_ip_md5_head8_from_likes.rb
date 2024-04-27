class RemoveIpMd5Head8FromLikes < ActiveRecord::Migration[7.0]
  def change
    remove_column :likes, :ip_md5_head8, :string
  end
end
