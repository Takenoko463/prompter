class AddCategoryToPrompts < ActiveRecord::Migration[7.0]
  def change
    add_reference :prompts, :category, foreign_key: true
  end
end
