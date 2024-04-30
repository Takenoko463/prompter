class AddIpToLikes < ActiveRecord::Migration[7.0]
  def change
    change_table :likes do |t|
      t.references :ip, foreign_key: true
    end
  end
end
