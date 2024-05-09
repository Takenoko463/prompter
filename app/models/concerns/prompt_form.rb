class PromptForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :word, :string
  attribute :category_id, :integer
  attribute :order, :string

  def result
    Prompt.includes([:ip,
                     :likes_ips,
                     :category, :comments]).search({ word:, category_id: }).ranking(order)
  end
end
