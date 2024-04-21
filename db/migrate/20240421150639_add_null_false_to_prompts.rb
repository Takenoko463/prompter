class AddNullFalseToPrompts < ActiveRecord::Migration[7.0]
  def change
    change_column_default :prompts, :category_id, from: nil, to: 0
  end
end
