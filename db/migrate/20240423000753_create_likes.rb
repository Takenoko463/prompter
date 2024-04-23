class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.string :ip_md5_head8, null: false, unique: true
      t.references :prompt, foreign_key: true
      t.timestamps
    end
  end
end
