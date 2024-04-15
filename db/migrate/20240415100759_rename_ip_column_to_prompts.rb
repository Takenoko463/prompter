class RenameIpColumnToPrompts < ActiveRecord::Migration[7.0]
  def change
    rename_column :prompts, :ip, :ip_md5_head8
  end
end
