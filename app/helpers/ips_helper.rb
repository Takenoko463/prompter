module IpsHelper
  def ip_to_md5_head8(ip)
    Digest::MD5.hexdigest(ip)[0, 8]
  end

  def set_ip
    ip_plain = request.remote_ip
    ip_to_md5_head8(ip_plain)
  end

  # 使用しているuserのip
  def current_ip
    request.remote_ip
  end

  def current_ip_md5_head8
    ip_to_md5_head8(current_ip)
  end

  def your_ip?(ip_md5_head8)
    current_ip_md5_head8 == ip_md5_head8
  end
end
