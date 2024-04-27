class RemoveIpMd5Head8FromPrompts < ActiveRecord::Migration[7.0]
  def change
    remove_column :prompts, :ip_md5_head8, :string
  end
end
