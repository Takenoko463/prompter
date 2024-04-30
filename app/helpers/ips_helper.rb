module IpsHelper
  def ip_to_md5_head8(ip)
    Digest::MD5.hexdigest(ip)[0, 8]
  end

  # 通信内容から取得したip
  def current_ip_plain
    request.remote_ip
  end

  def set_ip
    ip_to_md5_head8(current_ip_plain)
  end

  def current_ip_md5_head8
    ip_to_md5_head8(current_ip_plain)
  end

  def your_ip?(ip_md5_head8)
    current_ip_md5_head8 == ip_md5_head8
  end

  # 以下sessionでのip管理
  def ip_registered?
    session[:ip_id].present?
  end

  # sessionをいじってからのデータ操作を防ぐ
  def legitimate_ip?
    your_ip?(current_ip.ip_md5_head8)
  end

  def authenticate_ip!
    redirect_to root_path unless ip_registered?
  end

  def current_ip
    Ip.find(session[:ip_id])
  end
end
