module PromptsHelper
  def your_prompt?(prompt)
    current_ip_md5_head8 == prompt.ip_md5_head8
  end

  def last_prompt_nick_name(model)
    cookies[:last_nick_name].presence || model.nick_name
  end
end
