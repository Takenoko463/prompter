class AddIpToPrompts < ActiveRecord::Migration[7.0]
  def change
    change_table :prompts do |t|
      t.references :ip, foreign_key: true
    end
  end
end
