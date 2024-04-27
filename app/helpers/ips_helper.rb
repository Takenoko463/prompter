module IpsHelper
  def ip_to_md5_head8(ip)
    Digest::MD5.hexdigest(ip)[0, 7]
  end

  def set_ip
    ip_plain = request.remote_ip
    ip_to_md5_head8(ip_plain)
  end

  # 通信内容から取得したip
  def current_ip
    request.remote_ip
  end

  def current_ip_md5_head8
    ip_to_md5_head8(current_ip)
  end

  def your_ip?(ip_md5_head8)
    current_ip_md5_head8 == ip_md5_head8
  end

  # 以下sessionでのip管理
  def ip_registered?
    session.respond_to? :ip_id
  end

  # sessionをいじってからのデータ操作を防ぐ
  def legitimate_ip?
    your_ip?(Ip.find(session[:ip_id]).ip_md5_head8)
  end
end
