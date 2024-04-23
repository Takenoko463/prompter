module LikesHelper
  include IpsHelper
  def liked?(id)
    likes = cookies[:likes] ? JSON.parse(cookies[:likes]) : []
    likes.include?(id)
  end
end
