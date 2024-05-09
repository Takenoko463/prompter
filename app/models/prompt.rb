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
  scope :subtree_category, lambda { |category_id|
                             category_id ||= 0
                             category = Category.find(category_id)
                             subtree_ids = category.subtree.pluck(:id)
                             where(category_id: subtree_ids)
                           }
  scope :content_cont, lambda { |word|
                         where('prompts.content like ?', "%#{word}%")
                       }
  scope :order_by_likes, lambda {
    select('prompts.*', 'count(likes.id) AS likes_count').left_outer_joins(:likes)
                                                         .group('prompts.id').order('likes_count desc')
  }
  scope :order_by_comments, lambda {
    select('prompts.*', 'count(comments.id) AS comments_count').left_outer_joins(:comments)
                                                               .group('prompts.id').order('comments_count desc')
  }

  def self.search(params)
    subtree_category(params[:category_id]).content_cont(params[:word])
  end

  def self.ranking(order)
    case order
    when 'likes'
      order_by_likes
    when 'created'
      order(created_at: :desc)
    when 'comments'
      order_by_comments
    else
      order_by_likes
    end
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
