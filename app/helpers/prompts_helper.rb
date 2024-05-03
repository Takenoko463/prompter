module PromptsHelper
  include CategoriesHelper
  include LikesHelper
  include IpsHelper
  def your_prompt?(prompt)
    your_ip?(prompt.ip.ip_md5_head8)
  end

  def last_prompt_nick_name(model)
    model.nick_name || cookies[:last_nick_name].presence
  end
end
