module LikesHelper
  include IpsHelper
  def liked?(prompt)
    likes = cookies[:likes] ? JSON.parse(cookies[:likes]) : []
    likes.include?(prompt.id)
  end
end
