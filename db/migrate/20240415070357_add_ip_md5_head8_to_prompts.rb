class AddIpMd5Head8ToPrompts < ActiveRecord::Migration[7.0]
  def change
    add_column :prompts, :ip_md5_head8, :string
  end
end