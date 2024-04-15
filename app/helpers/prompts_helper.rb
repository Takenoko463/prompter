module PromptsHelper
  def your_prompt?(prompt)
    current_ip_md5_head8 == prompt.ip_md5_head8
  end
end
