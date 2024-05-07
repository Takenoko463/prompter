class Prompt < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  attribute :nick_name, :string, default: 'no name prompter'
  validates :answer, length: { maximum: 3000 }
  belongs_to_active_hash :ai
  belongs_to :category
  belongs_to :ip
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes_ips, through: :likes, source: :ip
  with_options presence: true do
    validates :title, length: { maximum: 30 }
    validates :nick_name, length: { maximum: 30 }
    validates :content, length: { minimum: 5, maximum: 3000 }
    validates :ai_id, numericality: { other_than: 0, message: 'must exist' }
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[content]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[likes comments category]
  end

  def first_line
    content.split("\n").first
  end

  def remaining_content
    content.split("\n")[1..].join("\n")
  end

  def liked_by?(ip)
    likes_ips.pluck(:id).include?(ip.id)
  end
end
