class AddIpToPrompts < ActiveRecord::Migration[7.0]
  def change
    add_column :prompts, :ip, :string, null: false
  end
end
