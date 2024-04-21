class AddAnswerToPrompts < ActiveRecord::Migration[7.0]
  def change
    add_column :prompts, :answer, :text
  end
end
