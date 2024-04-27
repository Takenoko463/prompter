class IpsController < ApplicationController
  include IpsHelper
  def create
    return if ip_registered?

    ip = Ip.find_by(ip_md5_head8: current_ip_md5_head8)
    ip ||= Ip.create(ip_md5_head8: current_ip_md5_head8)
    session[:ip_id] = ip.id
  end
end
