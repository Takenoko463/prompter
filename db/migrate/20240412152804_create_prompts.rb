class CreatePrompts < ActiveRecord::Migration[7.0]
  def change
    create_table :prompts do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.string :nick_name, null: false
      t.integer :ai_id, null: false
      t.timestamps
    end
  end
end
