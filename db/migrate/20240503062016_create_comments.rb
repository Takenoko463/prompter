class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :nick_name, null: false,default: 'commenter'
      t.text :content, null: false
      t.references :prompt, foreign_key: true
      t.references :ip, foreign_key: true
      t.timestamps
    end
  end
end
